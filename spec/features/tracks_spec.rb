require 'rails_helper'

RSpec.feature "Tracks", type: :feature do
  context "when visiting root" do
    it "shows Tracks page" do
      visit root_path

      expect(page).to have_content("Tracks")
    end
  end
end
