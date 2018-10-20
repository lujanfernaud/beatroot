require 'rails_helper'

RSpec.describe Beatroot, type: :model do
  describe ".tracks", :vcr do
    it "retrieves tracks from Beatroot's API" do
      url     = ApiHelpers::url
      headers = ApiHelpers::headers
      tracks  = { "tracks" => "Tracks" }

      allow(HTTParty).to receive(:get).with(url, headers).and_return(tracks)

      result = Beatroot.tracks

      expect(result).to eq("Tracks")
    end
  end

  describe ".track", :vcr do
    it "retrieves a single track from Beatroot's API" do
      track_id = 1
      url      = "#{ApiHelpers::url}/#{track_id}"
      headers  = ApiHelpers::headers
      track    = { "track" => "A single track" }

      allow(HTTParty).to receive(:get).with(url, headers).and_return(track)

      result = Beatroot.track(track_id)

      expect(result).to eq("A single track")
    end
  end
end
