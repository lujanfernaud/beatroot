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
    duration = track["duration"]

    return unless duration

    Time.at(duration).gmtime.strftime("PT%HH%MM%SS")
  end

  def artist_name
    return unless artist

    artist["name"]
  end

  def artist
    track["artist"]
  end

  def direct_contributors
    return unless contributors

    direct_contributors = contributors.select(&direct)

    create_objects_for direct_contributors
  end

  def contributors
    track["contributors"]
  end

  def indirect_contributors
    return unless contributors

    indirect_contributors = contributors.select(&indirect)

    create_objects_for indirect_contributors
  end

  def record_label_name
    record_labels = track["record_labels"]

    return unless record_labels

    if record_labels.first.present?
      record_labels.first["name"]
    end
  end

  def pline
    record_labels = track["record_labels"]

    return unless record_labels

    if record_labels.first.present?
      record_labels.first["p_line"]
    end
  end

  def tags
    track["tags"]
  end

  def parental_warning
    explicit != nil
  end

  def explicit
    track["explicit"]
  end

  private

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
end
