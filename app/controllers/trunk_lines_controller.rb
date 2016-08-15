class TrunkLinesController < ApplicationController
  autocomplete :trunk_line, :full_address
  def index
    @search  = params[:search] || {}
    if (@search[:range] == "1")
      @trunklines = TrunkLine.near(@search[:address],0.5, units: "km")
    else
      @trunklines = TrunkLine.search(@search[:address])
    end

    @hash = Gmaps4rails.build_markers(@trunklines) do |trunkline, marker|
      marker.lat trunkline.latitude
      marker.lng trunkline.longitude
      marker.infowindow render_to_string(:partial=> 'info_box', :locals => { :trunkline => trunkline})
    end
  end

end
