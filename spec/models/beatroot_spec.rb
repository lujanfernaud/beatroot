require 'rails_helper'

RSpec.describe Beatroot, type: :model do
  describe ".tracks", :vcr do
    it "retrieves tracks from Beatroot's API" do
      url     = "#{Beatroot::URL}/tracks"
      token   = Beatroot::TOKEN
      headers = { headers: { "Authorization" => "Token token=#{token}" } }
      tracks  = { "tracks" => "Tracks" }

      allow(HTTParty).to receive(:get).with(url, headers).and_return(tracks)

      result = Beatroot.tracks

      expect(result).to eq("Tracks")
    end
  end
end
