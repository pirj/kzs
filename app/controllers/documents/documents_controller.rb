class Documents::DocumentsController < ResourceController
  layout 'base'
  actions :index
  has_scope :per, default: 10, only: [:index]

  has_scope :with_type, except: [:batch] do |controller, scope, value|
    case value
    when 'orders' then scope.orders
    when 'mails' then scope.mails
    when 'reports' then scope.reports
    else
      scope
    end
  end

  has_scope :with_state,
            default: 'all_but_draft',
            except: [:batch] do |controller, scope, value|
    case value
    when 'draft' then scope.draft
    when 'prepared' then scope.prepared
    when 'approved' then scope.approved
    else
      scope.not_draft
    end
  end

  def index
    @search = collection.ransack(params[:q])

    documents =
        if params[:quick]
          collection.lookup(params[:quick])
        else
          @search.result(distinct: true)
        end

    list_decorator = Documents::ListDecorator
    each_decorator = Documents::ListShowDecorator

    documents = documents.with_read_marks_for(current_user)

    @documents = list_decorator.decorate documents, with: each_decorator
  end

  # TODO: give it descriptive name as it only returns search results count
  def search
    @documents = end_of_association_chain
      .ransack(params[:q])
      .result(distinct: true)
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  # redirect to document-type edit-page
  def edit
    document = Document.find(params[:id]).accountable
    redirect_to edit_polymorphic_path(document)
  end

  # redirect to document-type show-page
  def show
    document = Document.find(params[:id]).accountable
    redirect_to polymorphic_path(document)
  end

  # TODO-prikha: next method needs change from GET to POST
  # uses params like so:
  #     :state = 'approved'
  #     :documents_ids = [1,4,6]
  #
  def batch
    state = params[:state]
    @documents = collection.find(params[:document_ids])
    @accountables = @documents.map(&:accountable)

    if batch_can?(state, @accountables)
      @accountables.each do |accountable|
        accountable.transition_to!(state, default_metadata)
      end
      flash[:notice] = t('documents_updated')
    else
      flash[:error] = t('access_denied')
    end

    redirect_to :back, notice: flash[:notice], error: flash[:error]
  end

  def history
    document = Document.find(params[:id])
    @transitions = document.document_transitions
    @document = Documents::StateDecorator.decorate document
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  private

  # TODO: might be extracted out
  def batch_can?(state, accountables)
    cans = accountables.map do |accountable|
      a = accountable.can_transition_to?(state)
      b = can_apply_state?(state, accountable)
      a && b
    end
    cans.all?
  end

  # TODO: enable or delete pushing unapproved records up
  # using such lines:
  #   select('documents.*').
  #   order('documents.approved_at nulls first').

  def end_of_association_chain
    super
    .visible_for(current_organization.id)
    .includes(:sender_organization, :recipient_organization)
    .order(sort_column + ' ' + sort_direction)
  end

  def default_metadata
    { user_id: current_user.id }
  end

  def sort_column
    column = sort_fields.include?(params[:sort]) ? params[:sort] : 'updated_at'
    # TODO-prikha: следующая строка закомментирована, потому что при сортировке по полю title,
    # она начинает искать по documents.title
    #avoid_ambiguous(column)
  end

  def sort_fields
    resource_class.column_names + complex_sort_fields
  end

  def complex_sort_fields
    %w(organizations.short_title recipient_organizations_documents.short_title)
  end

  # TODO-prikha пожалуйста опиши зачем этот метод,
  # не понятно, почему етсь колонки, к которым
  def avoid_ambiguous(column_name)
    if column_name.match('\.')
      column_name
    else
      [resource_table_name, column_name].join('.')
    end
  end

  def resource_table_name
    resource_class.table_name
  end
end
