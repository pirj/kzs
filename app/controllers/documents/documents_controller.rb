class Documents::DocumentsController < ResourceController
  layout 'base'
  actions :index

  def index

    @documents = Documents::ListDecorator.decorate(collection, with: Documents::ListShowDecorator)
  end

  private
  def end_of_association_chain
    super.
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