class XmlDownloadsController < ApplicationController
  def create
    id = params[:id]

    track_json = Beatroot.track(id)
    track_xml  = TrackXmlBuilder.run(track_json)

    send_data track_xml, filename: "track_#{id}.xml"
  end
end
