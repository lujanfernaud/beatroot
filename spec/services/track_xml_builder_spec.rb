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
end