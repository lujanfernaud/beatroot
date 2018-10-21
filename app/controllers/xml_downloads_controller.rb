# frozen_string_literal: true

class XmlDownloadsController < ApplicationController
  def create
    id = params[:id]

    track_json      = Beatroot.track(id)
    track_decorated = TrackDecorator.new(track_json)
    track_xml       = TrackXmlBuilder.run(track_decorated)

    send_data track_xml, filename: "track_#{id}.xml"
  end
end
