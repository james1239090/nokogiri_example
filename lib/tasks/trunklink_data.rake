desc "clone trunklink date to db"

task :clone_data => [:environment] do
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  url = URI.encode("http://waste.ksepb.gov.tw/index.php?s_D=左營區&s_E=福山里&s_F=&carry_linePageSize=100000")
  doc = Nokogiri::HTML(open(url))

  doc.css(".Row").each do |item|
    line = TrunkLine.new
    line.respond_area = item.at_css("td:nth-child(1)").text
    line.car_no = item.at_css("td:nth-child(2)").text
    line.number = item.at_css("td:nth-child(3)").text
    line.dist = item.at_css("td:nth-child(4) a").text
    line.vil = item.at_css("td:nth-child(5) a").text
    line.address = item.at_css("td:nth-child(6)").text
    line.around_time = item.at_css("td:nth-child(7)").text
    line.recover_date = item.at_css("td:nth-child(8)").text
    line.save
  end

end
desc "Clone Data for dist"
task :clone_dist => [:environment] do
  require 'nokogiri'
  require 'open-uri'


  url = URI.encode("http://waste.ksepb.gov.tw/index.php")
  doc = Nokogiri::HTML(open(url))


  doc.css("#Contentcarry_lineSearchs_D option").each do |item|
    dist = Dist.new
    dist.title = item.text
    dist.save
  end

end


desc "clone Data for Vil"
task :clone_vil => [:environment] do
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  url_home = "http://waste.ksepb.gov.tw/index.php"
  url = URI.encode(url_home)
  doc = Nokogiri::HTML(open(url))

  doc.css("#Contentcarry_lineSearchs_E option").each do |item|
    vil = Village.new
    vil.title = item.text
    vil.save
  end

  # end

end
