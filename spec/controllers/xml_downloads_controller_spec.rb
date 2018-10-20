require 'rails_helper'

RSpec.describe XmlDownloadsController, type: :controller do
  describe "POST #create" do
    it "creates a new XMLDownload" do
      post :create, params: { id: 1 }

      expect(response).to redirect_to(root_path)
    end
  end
end
