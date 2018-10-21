require 'rails_helper'

RSpec.describe TrackXmlBuilder do
  describe "default behaviour" do
    it "has version, encoding, and 'Track' as root" do
      track = OpenStruct.new()
      xml  = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
        </Track>
      XML

      result = TrackXmlBuilder.run(track)

      expect(result).to be_equivalent_to(xml)
    end
  end

  context "with track object" do
    it "adds ISRC" do
      track = OpenStruct.new(isrc: "GBG3H1000203")

      xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <ISRC>GBG3H1000203</ISRC>
        </Track>
      XML

      result = TrackXmlBuilder.run(track)

      expect(result).to be_equivalent_to(xml)
    end

    it "adds ReferenceTitle" do
      track = OpenStruct.new(
        reference_title?: true,
        title:    "Sweet Lorraine",
        subtitle: "live at the O2"
      )

      xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <ReferenceTitle>
            <TitleText>Sweet Lorraine</TitleText>
            <SubTitle>live at the O2</SubTitle>
          </ReferenceTitle>
        </Track>
      XML

      result = TrackXmlBuilder.run(track)

      expect(result).to be_equivalent_to(xml)
    end

    it "adds Duration" do
      track = OpenStruct.new(duration: "PT00H03M22S")

      xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <Duration>PT00H03M22S</Duration>
        </Track>
      XML

      result = TrackXmlBuilder.run(track)

      expect(result).to be_equivalent_to(xml)
    end

    it "adds ArtistName" do
      track = OpenStruct.new(
        artist: true,
        artist_name: "Tony Crombie feat. Robert Robertson"
      )

      xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <ArtistName>Tony Crombie feat. Robert Robertson</ArtistName>
        </Track>
      XML

      result = TrackXmlBuilder.run(track)

      expect(result).to be_equivalent_to(xml)
    end

    it "adds Contributors" do
      track = OpenStruct.new(
        contributors: true,
        direct_contributors: [
                               OpenStruct.new(
                                 name:  "Tony Crombie",
                                 roles: "Artist"),

                               OpenStruct.new(
                                 name:  "Robert Robertson",
                                 roles: "Artist"),

                               OpenStruct.new(
                                 name:  "Bill Wallis",
                                 roles: "Mixer")
                             ]
      )

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

      result = TrackXmlBuilder.run(track)

      expect(result).to be_equivalent_to(xml)
    end

    it "adds IndirectContributors" do
      track = OpenStruct.new(
        contributors: true,
        indirect_contributors: [
                                 OpenStruct.new(
                                   name:  "June Blane",
                                   roles: "Composer"),

                                 OpenStruct.new(
                                   name:  "Marty Ford",
                                   roles: "Lyricist"),

                                 OpenStruct.new(
                                   name:  "Philip Pike",
                                   roles: "Lyricist")
                               ]
      )

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

      result = TrackXmlBuilder.run(track)

      expect(result).to be_equivalent_to(xml)
    end

    it "adds RecordLabelName" do
      track = OpenStruct.new(record_label_name: "Harrison James Music")

      xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <RecordLabelName>Harrison James Music</RecordLabelName>
        </Track>
      XML

      result = TrackXmlBuilder.run(track)

      expect(result).to be_equivalent_to(xml)
    end

    it "adds PLine" do
      track = OpenStruct.new(pline: "2010 Harrison James Music")

      xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <PLine>
            <Year>2010</Year>
            <PLineText>2010 Harrison James Music</PLineText>
          </PLine>
        </Track>
      XML

      result = TrackXmlBuilder.run(track)

      expect(result).to be_equivalent_to(xml)
    end

    it "adds Genres" do
      track = OpenStruct.new(
        tags: [ { "classification" => "genre", "name" => "Dance" },
                { "classification" => "genre", "name" => "Tech House" } ]
      )

      xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <Genre>Dance</Genre>
          <Genre>Tech House</Genre>
        </Track>
      XML

      result = TrackXmlBuilder.run(track)

      expect(result).to be_equivalent_to(xml)
    end

    it "adds Explicit ParentalWarningType" do
      track = OpenStruct.new(parental_warning: true, explicit: true)

      xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <ParentalWarningType>Explicit</ParentalWarningType>
        </Track>
      XML

      result = TrackXmlBuilder.run(track)

      expect(result).to be_equivalent_to(xml)
    end

    it "adds NotExplicit ParentalWarningType" do
      track = OpenStruct.new(parental_warning: true, explicit: false)

      xml = <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <ParentalWarningType>NotExplicit</ParentalWarningType>
        </Track>
      XML

      result = TrackXmlBuilder.run(track)

      expect(result).to be_equivalent_to(xml)
    end
  end
end
