require 'rails_helper'

RSpec.describe TrackXmlBuilder do
  describe "default behaviour" do
    it "has version, encoding, and 'Track' as root" do
      json = {}
      xml  = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
        </Track>
      XML

      result = TrackXmlBuilder.run(json)

      expect(result).to be_equivalent_to(xml)
    end
  end

  context "with track json" do
    it "adds ISRC" do
      json = { "isrc" => "GBG3H1000203" }

      xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <ISRC>GBG3H1000203</ISRC>
        </Track>
      XML

      result = TrackXmlBuilder.run(json)

      expect(result).to be_equivalent_to(xml)
    end

    it "adds ReferenceTitle" do
      json = { "title"    => "Back To Life",
               "subtitle" => "(1Xtra Live Lounge)" }

      xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <ReferenceTitle>
            <TitleText>Back To Life</TitleText>
            <SubTitle>(1Xtra Live Lounge)</SubTitle>
          </ReferenceTitle>
        </Track>
      XML

      result = TrackXmlBuilder.run(json)

      expect(result).to be_equivalent_to(xml)
    end
  end
end
