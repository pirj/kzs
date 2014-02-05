# coding: utf-8
module PageHeaderHelper
  # render back btn for page header with left-arrow
  # 'path' — path to collection or resource
  def header_back_btn path
    if path
      content_tag :li do
        link_to path, class: 'btn btn-default m-back-btn' do
          content_tag(:span, nil, class: 'fa fa-arrow-left')+
          content_tag(:span, 'Назад')
        end
      end
    end
  end


  # render page-title block html
  def header_title &block
    content_tag :li, class: 'brand' do
      yield
    end.html_safe
  end

  # render search form with single input for page header
  # args mapping to form input
  def header_search_form path, *args
    form_tag path, class: 'navbar-form navbar-left' do
      content_tag(:div, class: 'input-group') do
        text_field_tag(:q, nil, {class: 'form-control js-input-with-icon' }.merge(*args))+
        content_tag(:span, nil, class: 'input-group-icon search')
      end
    end
  end

end