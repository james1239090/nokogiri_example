class TrunkLinesController < ApplicationController

  def index
    @trunklines = TrunkLine.all.with_address(params[:search][:address])

    @hash = Gmaps4rails.build_markers(@trunklines) do |trunkline, marker|
      marker.lat trunkline.latitude
      marker.lng trunkline.longitude
      marker.infowindow render_to_string(:partial=> 'info_box', :locals => { :trunkline => trunkline})
    end




  end

  # def search
  #   @search = params[:search][:address]
  #   puts "#{@search}"
  # end

  def show

  end

end
