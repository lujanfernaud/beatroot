require 'rails_helper'

RSpec.feature "Tracks", type: :feature do
  context "when visiting root" do
    it "shows Tracks page", :vcr do
      visit root_path

      expect(page).to have_content("Tracks")
    end

    it "shows list of tracks" do
      url     = ApiHelpers::url
      headers = ApiHelpers::headers
      tracks  = { "tracks" => [{
        "artist" => { "name" => "Rebecca Ferguson" },
        "full_title" => "Too Good To Lose"}] }

      allow(HTTParty).to receive(:get).with(url, headers).and_return(tracks)

      visit root_path

      within ".track__title" do
        expect(page).to have_content("Rebecca Ferguson - Too Good To Lose")
      end
    end
  end
end
