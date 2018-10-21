# frozen_string_literal: true

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
        add_isrc
        add_reference_title
        add_duration
        add_artist_name
        add_contributors
        add_indirect_contributors
        add_record_label_name
        add_pline
        add_genres
        add_parental_warning
      end
    end

    def add_isrc
      if isrc
        xml.ISRC isrc
      end
    end

    def add_reference_title
      if reference_title?
        xml.ReferenceTitle do
          xml.TitleText title
          xml.SubTitle  subtitle
        end
      end
    end

    def add_duration
      if duration
        xml.Duration duration
      end
    end

    def add_artist_name
      if artist_name
        xml.ArtistName artist_name
      end
    end

    def add_contributors
      if direct_contributors
        direct_contributors.each do |contributor|
          xml.Contributor do
            xml.Name contributor.name
            xml.Role contributor.roles
          end
        end
      end
    end

    def add_indirect_contributors
      if indirect_contributors
        indirect_contributors.each do |contributor|
          xml.IndirectContributor do
            xml.Name contributor.name
            xml.Role contributor.roles
          end
        end
      end
    end

    def add_record_label_name
      if record_label_name
        xml.RecordLabelName record_label_name
      end
    end

    def add_pline
      if pline
        xml.PLine do
          xml.Year      pline.year
          xml.PLineText pline.text
        end
      end
    end

    def add_genres
      if genres
        genres.each do |genre|
          xml.Genre genre
        end
      end
    end

    def add_parental_warning
      if parental_warning
        xml.ParentalWarningType parental_warning
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
    delegate :genres,                to: :track
    delegate :parental_warning,      to: :track
end
