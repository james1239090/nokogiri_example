class TrunkLinesController < ApplicationController

  def index
    @trunklines = TrunkLine.first

    @hash = Gmaps4rails.build_markers(@trunklines) do |trunkline, marker|
      marker.lat trunkline.latitude
      marker.lng trunkline.longitude
      marker.infowindow render_to_string(:partial=> 'info_box', :locals => { :trunkline => trunkline})
    end
  end

  def show

  end

end
