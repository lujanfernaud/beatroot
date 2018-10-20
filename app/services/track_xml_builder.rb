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

        if duration?
          xml.Duration duration_formatted
        end

        if artist_name
          xml.ArtistName artist_name
        end

        if direct_contributors
          direct_contributors.each do |contributor|
            xml.Contributor do
              xml.Name contributor["name"]
              xml.Role contributor["roles"].join(", ").gsub("Featured", "")
            end
          end
        end

        if indirect_contributors
          indirect_contributors.each do |contributor|
            xml.IndirectContributor do
              xml.Name contributor["name"]
              xml.Role contributor["roles"].join(", ")
            end
          end
        end

        if record_label_name
          xml.RecordLabelName record_label_name
        end
      end
    end

    def isrc
      json["isrc"]
    end

    def reference_title?
      json["title"] && json["subtitle"]
    end

    def duration?
      json["duration"]
    end

    def duration_formatted
      Time.at(json["duration"]).gmtime.strftime("PT%HH%MM%SS")
    end

    def artist_name
      return unless artist

      artist["name"]
    end

    def artist
      json["artist"]
    end

    def direct_contributors
      return unless contributors

      contributors.select { |item| item["direct"] == true }
    end

    def contributors
      json["contributors"]
    end

    def indirect_contributors
      return unless contributors

      contributors.select { |item| item["direct"] == false }
    end

    def record_label_name
      record_labels = json["record_labels"]

      return unless record_labels

      if record_labels.first.present?
        record_labels.first["name"]
      end
    end
end
