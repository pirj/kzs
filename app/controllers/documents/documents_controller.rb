# coding: utf-8

class Documents::DocumentsController < ResourceController
  layout 'base'
  actions :index
  has_scope :per, default: 10, only: [:index]
  has_scope :with_type, except: [:batch] do |controller, scope, value|
    case value
    when 'orders' then scope.orders
    when 'mails' then scope.mails
    when 'reports' then scope.reports
    when 'unread' then scope.inbox(controller.current_user.organization).unread_by(controller.current_user)
    when 'conformated' then scope.conformated
    else
      scope
    end
  end

  has_scope :with_state,
            default: 'all_but_trashed',
            except: [:batch] do |controller, scope, value|
    case value
    when 'draft' then scope.draft
    when 'prepared' then scope.prepared
    when 'approved' then scope.approved
    when 'trashed' then scope.trashed
    else
      scope.not_draft.not_trashed
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

    @documents = list_decorator.decorate documents, with: each_decorator

    @test = Document.joins('LEFT JOIN documents_users ON documents.id = documents_users.document_id').
                      joins('LEFT JOIN users ON users.id = documents_users.user_id').
                      joins('LEFT JOIN conformations ON users.id =  conformations.user_id').
                      where('conformations.conformed ISNULL
                            AND users.id IS NOT NULL').
                      visible_for(current_organization.id).
                      select('DISTINCT documents.id')
    #.where(:conformations)
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
      redirect_to :back, flash: { notice: t('documents_updated') }
    else
      redirect_to :back, flash: { error: t('access_denied') }
    end
  end

  def history
    document = Document.find(params[:id])
    @transitions = document.document_transitions
    @document = Documents::StateDecorator.decorate document
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def destroy
    document = Document.find(params[:id])
    document.destroy_by(current_user)
    flash[:notice] = 'Документ удален. Вы можете увидеть его в списке удаленных документов.'
    redirect_to documents_path
  end

  private

  def batch_can?(state, accountables)
    cans = accountables.map do |accountable|
      accountable.can_transition_to?(state) &&
        can_apply_state?(state, accountable)
    end
    cans.all?
  end

  def end_of_association_chain
    super
    .accessible_by(current_ability)
    .includes(:sender_organization, :recipient_organization)
    .order(avoid_ambiguous(sort_column) + ' ' + sort_direction)
    # .visible_for(current_organization.id)
  end

  def default_metadata
    { user_id: current_user.id }
  end

  def sort_column
    sort_fields.include?(params[:sort]) ? params[:sort] : 'updated_at'
  end

  def sort_fields
    resource_class.column_names + complex_sort_fields
  end

  # В случае если происходит многократный join одной и той же таблицы ее имя изменяется автоматически
  # в первом случае это имя самой таблицы, а затем имя ассоциации
  def complex_sort_fields
    %w(organizations.short_title recipient_organizations_documents.short_title)
  end

  # Если в рамках одного запроса появляется несколько таблиц с одинаковыми именами столбцов
  # мы увидим PG::AmbiguousColumn: ERROR:  column reference "updated_at" is ambiguous
  # вот чтобы этого избежать можно однозначно определить имена столбцов.
  def avoid_ambiguous(column_name)
    if column_name.match('\.')
      column_name
    else
      [resource_class.table_name, column_name].join('.')
    end
  end
end
