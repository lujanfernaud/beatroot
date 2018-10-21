# frozen_string_literal: true

# Decorates track's json.
class TrackDecorator
  attr_reader :track

  def initialize(track)
    @track = track
  end

  def isrc
    track["isrc"]
  end

  def reference_title?
    title && subtitle
  end

  def title
    track["title"]
  end

  def subtitle
    track["subtitle"]
  end

  def duration
    return unless track_duration

    Time.at(track_duration).gmtime.strftime("PT%HH%MM%SS")
  end

  def artist_name
    return unless artist

    artist["name"]
  end

  def direct_contributors
    return unless contributors

    direct_contributors = contributors.select(&direct)

    create_objects_for direct_contributors
  end

  def indirect_contributors
    return unless contributors

    indirect_contributors = contributors.select(&indirect)

    create_objects_for indirect_contributors
  end

  def record_label_name
    return unless record_labels

    record_labels_array["name"] if record_labels_array.present?
  end

  def pline
    return unless record_labels

    create_pline_object if record_labels_array.present?
  end

  def genres
    create_genres_array
  end

  def parental_warning
    return unless parental_warning_is_present

    is_explicit ? "Explicit" : "NotExplicit"
  end

  private

    def track_duration
      track["duration"]
    end

    def artist
      track["artist"]
    end

    def contributors
      track["contributors"]
    end

    def direct
      proc { |item| item["direct"] == true }
    end

    def indirect
      proc { |item| item["direct"] == false }
    end

    def create_objects_for(contributors)
      contributors.map do |contributor|
        OpenStruct.new(
          name:  contributor["name"],
          roles: contributor["roles"].join(", ").gsub("Featured", "")
        )
      end
    end

    def record_labels
      track["record_labels"]
    end

    def record_labels_array
      record_labels.first
    end

    def create_pline_object
      pline = record_labels_array["p_line"]

      OpenStruct.new(year: pline.gsub(/\s\w*/, ""), text: pline)
    end

    def create_genres_array
      return unless track["tags"]

      track["tags"].map do |tag|
        tag["name"] if tag["classification"] == "genre"
      end.compact
    end

    def parental_warning_is_present
      track["explicit"] != nil
    end

    def is_explicit
      track["explicit"]
    end
end
