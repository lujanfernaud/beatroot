require "builder"

class TrackXmlBuilder
  def self.run(json)
    new(json).run
  end

  def initialize(json)
    @json = json
    @xml  = Builder::XmlMarkup.new(indent: 2)
  end

  def run
    xml.instruct!

    generate_markup
  end

  private

    attr_reader :xml, :json

    def generate_markup
      xml.Track do
        if isrc
          xml.ISRC isrc
        end

        if reference_title?
          xml.ReferenceTitle do
            xml.TitleText json["title"]
            xml.SubTitle  json["subtitle"]
          end
        end
      end
    end

    def isrc
      json["isrc"]
    end

    def reference_title?
      json["title"] && json["subtitle"]
    end
end
