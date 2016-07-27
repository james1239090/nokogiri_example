class Trunkline
  def initialize
    @url_home = "http://waste.ksepb.gov.tw/index.php"
  end



  def clone_dist!
    Dist.destroy_all
    url = URI.encode(@url_home)
    doc = Nokogiri::HTML(open(url))

    items = doc.css("#Contentcarry_lineSearchs_D option").map{|dist| dist.text}
    items.shift

    items.each do |item|
      dist = Dist.new
      dist.title = item
      dist.save
    end
  end

  def clone_data!

    dists = Dist.all

    dists.each do |dist|

      page = find_end_page(dist.title)
      fetch_dist(dist.title,page)
    end

  end

  private
  def find_end_page(dist)
    url_dist = "?s_D=#{dist}&carry_linePageSize=100&carry_linePage=1"
    url_final = @url_home + url_dist
    url = URI.encode(url_final)
    doc = Nokogiri::HTML(open(url))

    page_reg = /linePage=([\d]+)/
    page = doc.at_css(".Navigator a:last-child")

    if page.nil?
      page = 1
    else
      page = page_reg.match(page["href"])[1]
    end
  end

  def fetch_dist(dist,page)
    for i in 1..page
      url_page = "&carry_linePage=#{i}"
      url_dist = "?s_D=#{dist}&carry_linePageSize=100"
      url_final = @url_home + url_dist + url_page
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
