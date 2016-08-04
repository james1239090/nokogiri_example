class TrunkLinesController < ApplicationController

  def index
    @trunklines = TrunkLine.first

    @hash = Gmaps4rails.build_markers(@trunklines) do |trunkline, marker|
      marker.lat trunkline.latitude
      marker.lng trunkline.longitude
      marker.infowindow "<div class='col-xs-12'>#{trunkline.full_address}</div>"
    end
  end

end
