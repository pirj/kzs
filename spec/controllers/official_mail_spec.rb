require 'spec_helper'

describe Documents::OfficialMailsController do
  describe "GET new" do
    it "has a 200 status code" do
      visit new_documents_official_mail_path
      expect(response.status).to eq(200)
    end
  end
end