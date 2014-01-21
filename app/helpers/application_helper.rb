# coding: utf-8
module ApplicationHelper
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields btn-primary btn dropdown icon-plus", data: {id: id, fields: fields.gsub("\n", "")})
  end


  def link_to_add_attachments(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(f.object.class.name.pluralize.downcase + "/" + association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields2 btn-primary btn dropdown icon-plus", data: {id: id, fields: fields.gsub("\n", "")})
  end





  def controller?(*controller)
     controller.include?(params[:controller])
   end

   def action?(*action)
     action.include?(params[:action])
   end

  def sortable(column, title=nil, extended_css_class=nil)
    title ||= column.titleize
    css_class = params[:status_sort] ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil, :status_sort => nil), :remote => true, :class => css_class
  end
   
   
   def sortable_status 
     css_class = params[:status_sort] ? "current #{sort_direction}" : nil
     direction = params[:status_sort] && params[:direction] == "desc" ? "asc" : "desc"
     link_to "Статус", {:status_sort => true, :direction => direction}, :remote => true, :class => css_class  
   end

  def new_document(document)
    if document.opened == false && document.sent == true && document.sender_organization_id != current_user.organization_id
      'class=new'
    else
      nil
    end
  end
   
  
end
