# frozen_string_literal: true

module ApiHelpers
  extend self

  def url
    "#{Beatroot::URL}/tracks"
  end

  def headers
    { headers: { "Authorization" => "Token token=#{Beatroot::TOKEN}" } }
  end
end
