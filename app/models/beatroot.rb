# frozen_string_literal: true

# Retrieves tracks from Beatroot's API.
class Beatroot
  URL   = "https://sync-api.beatroot.com/accounts/beatroot-records"
  TOKEN = ENV["beatroot_token"]

  def self.tracks
    get("#{URL}/tracks")["tracks"]
  end

  def self.get(url)
    HTTParty.get url, headers: { "Authorization" => "Token token=#{TOKEN}" }
  end
end
