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

    it "adds Duration" do
      json = { "duration" => 202 }

      xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <Duration>PT00H03M22S</Duration>
        </Track>
      XML

      result = TrackXmlBuilder.run(json)

      expect(result).to be_equivalent_to(xml)
    end

    it "adds ArtistName" do
      json = { "artist" =>
               { "name" => "Tony Crombie feat. Robert Robertson" } }

      xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <ArtistName>Tony Crombie feat. Robert Robertson</ArtistName>
        </Track>
      XML

      result = TrackXmlBuilder.run(json)

      expect(result).to be_equivalent_to(xml)
    end

    it "adds Contributors" do
      json = { "contributors" => [
               { "name"   => "Tony Crombie",
                 "direct" => true,
                 "roles"  => ["Artist"] },

               { "name"   => "Robert Robertson",
                 "direct" => true,
                 "roles"  => ["FeaturedArtist"] },

               { "name"   => "Bill Wallis",
                 "direct" => true,
                 "roles"  => ["Mixer"] }
             ]}

      xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <Contributor>
            <Name>Tony Crombie</Name>
            <Role>Artist</Role>
          </Contributor>
          <Contributor>
            <Name>Robert Robertson</Name>
            <Role>Artist</Role>
          </Contributor>
          <Contributor>
            <Name>Bill Wallis</Name>
            <Role>Mixer</Role>
          </Contributor>
        </Track>
      XML

      result = TrackXmlBuilder.run(json)

      expect(result).to be_equivalent_to(xml)
    end

    it "adds IndirectContributors" do
      json = { "contributors" => [
               { "name"   => "June Blane",
                 "direct" => false,
                 "roles"  => ["Composer"] },

               { "name"   => "Marty Ford",
                 "direct" => false,
                 "roles"  => ["Lyricist"] },

               { "name"   => "Philip Pike",
                 "direct" => false,
                 "roles"  => ["Lyricist"] }
             ]}

      xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <IndirectContributor>
            <Name>June Blane</Name>
            <Role>Composer</Role>
          </IndirectContributor>
          <IndirectContributor>
            <Name>Marty Ford</Name>
            <Role>Lyricist</Role>
          </IndirectContributor>
          <IndirectContributor>
            <Name>Philip Pike</Name>
            <Role>Lyricist</Role>
          </IndirectContributor>
        </Track>
      XML

      result = TrackXmlBuilder.run(json)

      expect(result).to be_equivalent_to(xml)
    end

    it "adds RecordLabelName" do
      json = { "record_labels" =>
               [{ "name" => "Harrison James Music" }] }

      xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <RecordLabelName>Harrison James Music</RecordLabelName>
        </Track>
      XML

      result = TrackXmlBuilder.run(json)

      expect(result).to be_equivalent_to(xml)
    end

    it "does not add RecordLabelName" do
      json = { "record_labels" => [] }

      xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
        </Track>
      XML

      result = TrackXmlBuilder.run(json)

      expect(result).to be_equivalent_to(xml)
    end
  end
end
