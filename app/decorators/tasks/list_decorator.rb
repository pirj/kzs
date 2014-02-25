# coding: utf-8
module Tasks
  class ListDecorator < Draper::CollectionDecorator
    delegate :current_page, :total_pages, :limit_value
  end
end