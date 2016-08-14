module TrunkLinesHelper
  def render_check_status(status)
    status = status || "0"
    if status == "0"
      false
    else
      true
    end
  end
end
