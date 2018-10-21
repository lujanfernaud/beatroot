# frozen_string_literal: true

require 'rails_helper'

RSpec.describe XmlDownloadsController, type: :controller do
  describe "POST #create", :vcr do
    it "creates a new XML download" do
      track_id = 2
      url      = "#{ApiHelpers::url}/#{track_id}"
      headers  = ApiHelpers::headers

      json = { "isrc"     => "GBG3H1000203",
               "title"    => "Sweet Lorraine",
               "subtitle" => "live at the O2",
               "artist"   =>
                 { "name" => "Tony Crombie feat. Robert Robertson" } }

      track = { "track" => json }

      xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <ISRC>GBG3H1000203</ISRC>
          <ReferenceTitle>
            <TitleText>Sweet Lorraine</TitleText>
            <SubTitle>live at the O2</SubTitle>
          </ReferenceTitle>
          <ArtistName>Tony Crombie feat. Robert Robertson</ArtistName>
        </Track>
      XML

      allow(HTTParty).to receive(:get).with(url, headers).and_return(track)

      post :create, params: { id: track_id }

      expect(response.body).to be_equivalent_to(xml)
    end
  end
end
