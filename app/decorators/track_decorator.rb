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

    contributors.select { |item| item["direct"] == true }
  end

  def contributors
    track["contributors"]
  end

  def indirect_contributors
    return unless contributors

    contributors.select { |item| item["direct"] == false }
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
end
