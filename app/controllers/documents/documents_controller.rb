class Documents::DocumentsController < ResourceController
  layout 'base'
  actions :index

  has_scope :per, default: 10, only: [:index]



  def index
    @search = end_of_association_chain.ransack(params[:q])
    @search.build_condition

    _documents = apply_scopes(@search.result(distinct: true))
    @documents = Documents::ListDecorator.decorate(_documents, with: Documents::ListShowDecorator)
  end

  def search
    @documents = collection.ransack(params[:q]).result(distinct: true)
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


  #TODO: @prikha now free for all (would be limited by initial scope!)
  # uses params like so:
  #     :state = 'approved'
  #     :documents_ids = [1,4,6]
  #
  def batch
    state = params[:state]

    @documents = end_of_association_chain.find(params[:document_ids])

    @accountables = @documents.map(&:accountable)

    if batch_can?(state, @documents) && applicable_state?(@accountables, state)
      @accountables.each do |accountable|
        accountable.transition_to!(state)
      end

      flash[:notice] = t('documents_updated')
    else
      flash[:notice] = t('access_denied')
    end

    redirect_to collection_path, notice: flash[:notice]
  end

  private
  def applicable_state?(accountables, state)
    accountables.map{|acc| acc.can_transition_to?(state)}.all?
  end

  def batch_can?(state, documents)
    documents.map{|doc| can?(ability_for(state), doc)}.all?
  end


  def end_of_association_chain
    super.
        #where(sender_organization_id: current_organization.id).
        includes(:sender_organization, :recipient_organization).
        select('documents.*').
        order('documents.approved_at nulls first').
        order(sort_column+' '+sort_direction)
  end

  def sort_column
    acceptable_sort_fields.include?(params[:sort]) ? params[:sort] : 'updated_at'
  end

  def acceptable_sort_fields
    resource_class.column_names + %w(organizations.short_title recipient_organizations_documents.short_title)
  end

end