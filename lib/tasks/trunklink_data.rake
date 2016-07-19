desc "clone trunklink date to db"

task :clone_data => [:environment] do
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  url = URI.encode("http://waste.ksepb.gov.tw/index.php?s_D=左營區&s_E=福山里&s_F=&carry_linePageSize=100000")
  doc = Nokogiri::HTML(open(url))

  doc.css(".Row").each do |item|
    line = TrunkLine.new
    line.respond_area = item.at_css("td:nth-child(1)").text[/[^\\r\\n\s]+/g]
    line.car_no = item.at_css("td:nth-child(2)").text[/[^\\r\\n\s]+/g]
    line.number = item.at_css("td:nth-child(3)").text[/[^\\r\\n\s]+/g]
    line.dist = item.at_css("td:nth-child(4)").text[/[^\\r\\n\s]+/g]
    line.vil = item.at_css("td:nth-child(5)").text[/[^\\r\\n\s]+/g]
    line.address = item.at_css("td:nth-child(6)").text[/[^\\r\\n\s]+/g]
    line.around_time = item.at_css("td:nth-child(7)").text[/[^\\r\\n\s]+/g]
    line.recover_date = item.at_css("td:nth-child(8)").text[/[^\\r\\n\s]+/g]
    line.save
  end


end
