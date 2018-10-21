require "builder"

class TrackXmlBuilder
  def self.run(track)
    new(track).run
  end

  def initialize(track)
    @track = track
    @xml   = Builder::XmlMarkup.new(indent: 2)
  end

  def run
    xml.instruct!

    generate_markup
  end

  private

    attr_reader :xml, :track

    def generate_markup
      xml.Track do
        if isrc
          xml.ISRC isrc
        end

        if reference_title?
          xml.ReferenceTitle do
            xml.TitleText title
            xml.SubTitle  subtitle
          end
        end

        if duration
          xml.Duration duration
        end

        if artist_name
          xml.ArtistName artist_name
        end

        if direct_contributors
          direct_contributors.each do |contributor|
            xml.Contributor do
              xml.Name contributor.name
              xml.Role contributor.roles
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

        if pline
          xml.PLine do
            xml.Year      pline.gsub(/\s\w*/, "")
            xml.PLineText pline
          end
        end

        if tags
          tags.each do |tag|
            next if !tag["classification"]["genre"]

            xml.Genre tag["name"]
          end
        end

        if parental_warning
          xml.ParentalWarningType explicit ? "Explicit" : "NotExplicit"
        end
      end
    end

    delegate :isrc,                  to: :track
    delegate :reference_title?,      to: :track
    delegate :title,                 to: :track
    delegate :subtitle,              to: :track
    delegate :duration,              to: :track
    delegate :artist_name,           to: :track
    delegate :direct_contributors,   to: :track
    delegate :indirect_contributors, to: :track
    delegate :record_label_name,     to: :track
    delegate :pline,                 to: :track
    delegate :tags,                  to: :track
    delegate :parental_warning,      to: :track
    delegate :explicit,              to: :track
end
