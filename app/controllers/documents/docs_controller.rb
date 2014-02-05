class Documents::DocsController < ApplicationController
  def index
    #  action for the main table
    @collection = Doc.all
  end
end