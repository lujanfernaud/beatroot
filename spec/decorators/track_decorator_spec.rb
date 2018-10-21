require 'rails_helper'

RSpec.describe TrackDecorator do
  describe "when a json track is received" do
    it "decorates 'isrc'" do
      json = { "isrc" => "GBG3H1000203" }

      track_decorated = TrackDecorator.new(json)

      expect(track_decorated.isrc).to eq(json["isrc"])
    end

    it "decorates 'title'" do
      json = { "title" => "Sweet Lorraine" }

      track_decorated = TrackDecorator.new(json)

      expect(track_decorated.title).to eq(json["title"])
    end

    it "decorates 'subtitle'" do
      json = { "subtitle" => "live at the O2" }

      track_decorated = TrackDecorator.new(json)

      expect(track_decorated.subtitle).to eq(json["subtitle"])
    end

    it "decorates 'duration'" do
      json = { "duration" => 202 }
      duration = "PT00H03M22S"

      track_decorated = TrackDecorator.new(json)

      expect(track_decorated.duration).to eq(duration)
    end

    it "decorates 'artist_name'" do
      artist_name = "Tony Crombie feat. Robert Robertson"
      json        = { "artist" => { "name" => artist_name } }

      track_decorated = TrackDecorator.new(json)

      expect(track_decorated.artist_name).to eq(artist_name)
    end

    it "decorates 'direct_contributors'" do
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
             ] }

      direct_contributors = [ OpenStruct.new(
                                name:  "Tony Crombie",
                                roles: "Artist"),

                              OpenStruct.new(
                                name:  "Robert Robertson",
                                roles: "Artist"),

                              OpenStruct.new(
                                name:  "Bill Wallis",
                                roles: "Mixer") ]

      track_decorated = TrackDecorator.new(json)

      expect(track_decorated.direct_contributors).to eq(direct_contributors)
    end

    it "decorates 'indirect_contributors'" do
      json = { "contributors" => [
               { "name"   => "Tony Crombie",
                 "direct" => false,
                 "roles"  => ["Artist"] },

               { "name"   => "Robert Robertson",
                 "direct" => false,
                 "roles"  => ["FeaturedArtist"] },

               { "name"   => "Bill Wallis",
                 "direct" => false,
                 "roles"  => ["Mixer"] }
             ] }

      indirect_contributors = [ OpenStruct.new(
                                  name:  "Tony Crombie",
                                  roles: "Artist"),

                                OpenStruct.new(
                                  name:  "Robert Robertson",
                                  roles: "Artist"),

                                OpenStruct.new(
                                  name:  "Bill Wallis",
                                  roles: "Mixer") ]

      track_decorated = TrackDecorator.new(json)

      expect(track_decorated.indirect_contributors).
        to eq(indirect_contributors)
    end

    it "decorates 'record_label_name'" do
      record_label_name = "Harrison James Music"
      json = { "record_labels" => [{ "name" => record_label_name }] }

      track_decorated = TrackDecorator.new(json)

      expect(track_decorated.record_label_name).to eq(record_label_name)
    end

    it "decorates 'pline'" do
      pline = "2010 Harrison James Music"
      json  = { "record_labels" => [{ "p_line" => pline }] }
      pline_object = OpenStruct.new(year: pline.gsub(/\s\w*/, ""), text: pline)

      track_decorated = TrackDecorator.new(json)

      expect(track_decorated.pline).to eq(pline_object)
    end

    it "decorates 'genres'" do
      json = { "tags" => [
               { "name" => "Dance",      "classification" => "genre" },
               { "name" => "Tech House", "classification" => "genre" },
             ] }

      genres = ["Dance", "Tech House"]

      track_decorated = TrackDecorator.new(json)

      expect(track_decorated.genres).to eq(genres)
    end

    it "only decorates 'genres' with content" do
      json = { "tags" => [
               { "name" => "Dance",           "classification" => "genre" },
               { "name" => "Tech House",      "classification" => "genre" },
               { "name" => "Like Dollars",    "classification" => "meaning" },
               { "name" => "Like Texts From", "classification" => "meaning" },
             ] }

      genres = ["Dance", "Tech House"]

      track_decorated = TrackDecorator.new(json)

      expect(track_decorated.genres).to eq(genres)
    end

    it "decorates 'explicit'" do
      json = { "explicit" => true }

      track_decorated = TrackDecorator.new(json)

      expect(track_decorated.explicit).to eq(json["explicit"])
    end
  end
end
