class TrunkLinesController < ApplicationController

  def index
    @trunklines = TrunkLine.first

    @hash = Gmaps4rails.build_markers(@trunklines) do |trunkline, marker|
      marker.lat trunkline.latitude
      marker.lng trunkline.longitude
      marker.infowindow "<div class='col-xs-12'><table><tbody><tr><td>#{trunkline.full_address}</td>#{trunkline.around_time}<td></td><tr></tbody><table></div>"
    end
  end

end
