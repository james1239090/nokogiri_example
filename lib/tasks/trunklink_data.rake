desc "clone trunklink date to db"

task :clone_data => [:environment] do
	Trunkline.new.clone_data!
end
desc "Clone Data for dist"
task :clone_dist => [:environment] do
	Trunkline.new.clone_dist!
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
