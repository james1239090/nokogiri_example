desc "clone trunklink date to db"

task :clone_data => [:environment] do
  require 'nokogiri'
  require 'open-uri'
  require 'uri'
  url_home = "http://waste.ksepb.gov.tw/index.php"

  dists = Dist.all

  dists.each do |dist|
    url_dist = "?s_D=#{dist.title}&carry_linePageSize=100"

    url_page = "&carry_linePage=1"
    url_final = url_home + url_dist + url_page
    url = URI.encode(url_final)

    doc = Nokogiri::HTML(open(url))

    page_reg = /linePage=([\d]+)/
    page = doc.at_css(".Navigator a:last-child")

    if page.nil?
    	page = 1
    else
    	page = page_reg.match(page["href"])[1]
    end

    for i in 1..page
      url_page = "&carry_linePage=#{i}"
      url_final = url_home + url_dist + url_page
      url = URI.encode(url_final)

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



  end



end
desc "Clone Data for dist"
task :clone_dist => [:environment] do
  require 'nokogiri'
  require 'open-uri'


  url = URI.encode("http://waste.ksepb.gov.tw/index.php")
  doc = Nokogiri::HTML(open(url))

  items = doc.css("#Contentcarry_lineSearchs_D option").map{|dist| dist.text}
  items.shift

  items.each do |item|
    dist = Dist.new
    dist.title = item
    dist.save
  end

end

desc "Task for test"
task :clone_test => [:environment] do
  require 'nokogiri'
  require 'open-uri'

  url = URI.encode("http://waste.ksepb.gov.tw/index.php?s_D=左營區&s_E=&s_F=&carry_linePageSize=10&carry_linePage=10")
  doc = Nokogiri::HTML(open(url))

  test = doc.at_css("a:nth-child(10)")["href"]
  oUrl = test = doc.at_css("a:nth-child(10)")["href"]
  test_re = /linePage=([\d]+)/
  a = test_re.match(oUrl)[1]
  puts "#{a}"

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
