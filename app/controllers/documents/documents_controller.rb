class Documents::DocumentsController < ResourceController
  layout 'base'
  actions :index

  def index
    @documents = Documents::ListDecorator.decorate(collection, with: Documents::ListShowDecorator)
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

    if can?(ability_for(state), @documents) && applicable_state?(@accountables, state)
      @accountables.transition_to!(state)
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


  def end_of_association_chain
    super.
        where(sender_organization_id: current_organization.id).
        includes(:sender_organization, :recipient_organization).
        order(sort_column+' '+sort_direction).
        page(params[:page]).per(2)
  end

  def sort_column
    acceptable_sort_fields.include?(params[:sort]) ? params[:sort] : 'updated_at'
  end

  def acceptable_sort_fields
    resource_class.column_names + %w(organizations.short_title recipient_organizations_documents.short_title)
  end
end