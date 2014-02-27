class Documents::DocumentsController < ResourceController
  layout 'base'
  actions :index

  has_scope :per, default: 10, only: [:index]

  def index
    @search = collection.ransack(params[:q])

    documents = if params[:quick]
      collection.lookup(params[:quick])
    else
      @search.result(distinct: true)
    end

    @documents = Documents::ListDecorator.decorate(documents, with: Documents::ListShowDecorator)
  end

  # Нужен только для посчета количества документов, которые подходят по всем параметрам
  #
  def search
    @documents = end_of_association_chain.ransack(params[:q]).result(distinct: true)
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
  #TODO: @prikha now free for all (would be limited by initial scope!)
  # uses params like so:
  #     :state = 'approved'
  #     :documents_ids = [1,4,6]
  #
  def batch
    state = params[:state]
    @documents = end_of_association_chain.find(params[:document_ids])
    @accountables = @documents.map(&:accountable)

    if batch_can?(state, @accountables)
      @accountables.each do |accountable|
        accountable.transition_to!(state, {user_id: current_user.id})
      end
      flash[:notice] = t('documents_updated')
    else
      flash[:error] = t('access_denied')
    end

    #redirect_to collection_path, notice: flash[:notice], error: flash[:error]
    redirect_to :back, notice: flash[:notice], error: flash[:error]
  end

  def history
    @transitions = Document.find(params[:id]).document_transitions
    respond_to do |format|
      format.js{ render layout: false }
    end
  end

  private

  def batch_can?(state, accountables)
    cans = accountables.map do |accountable|
      a = accountable.can_transition_to?(state)
      b = can_apply_state?(state, accountable)
      a && b
    end
    cans.all?
  end

  # TODO enable or delete pushing unapproved records up
  # using such lines:
  #   select('documents.*').
  #   order('documents.approved_at nulls first').

  def end_of_association_chain
    super.visible_for(current_organization.id).
    includes(:sender_organization, :recipient_organization).
    order(sort_column+' '+sort_direction)
    
  end

  def sort_column
    acceptable_sort_fields.include?(params[:sort]) ? params[:sort] : 'updated_at'
  end

  def acceptable_sort_fields
    resource_class.column_names + %w(organizations.short_title recipient_organizations_documents.short_title)
  end
end