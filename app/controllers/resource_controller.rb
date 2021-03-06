class ResourceController < ApplicationController
  inherit_resources

  helper_method :associations,
                :association_attributes,
                :attributes,
                :form_attributes,
                :sort_column,
                :sort_direction

  respond_to :html, :js, :json
  has_scope :page, default: 1, only: [:index]

  private

  def sort_column
    column_names = resource_class.column_names
    column_names.include?(params[:sort]) ? params[:sort] : "updated_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  def attributes
    resource_class.attribute_names - %w(id created_at updated_at)
  end

  def form_attributes
    resource_class.attribute_names - %w(id created_at updated_at)
  end

  def association_attributes
    associations(:belongs_to).map do |assoc|
      assoc.options[:foreign_key] || "#{assoc.name}_id"
    end
  end

  def associations(macro = nil)
    assoc = resource_class.reflect_on_all_associations
    assoc.select! { |a| a.macro == macro.to_sym } unless macro.blank?
    assoc
  end


end
