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
    TrunkLine.destroy_all
    dists = Dist.all

    dists.each do |dist|
      page = find_end_page(dist.title)
      fetch_dist(dist.title,page.to_i)
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
        one_row_data = item.css("td").map{|c| c.text}
        save_row(one_row_data)
      end
    end
  end
  def save_row(data)
    TrunkLine.transaction do
      line = TrunkLine.new
      line.respond_area = data[0]
      line.car_no = data[1]
      line.number = data[2]
      line.dist = data[3]
      line.vil = data[4]
      line.address = data[5]
      line.around_time = data[6]
      line.recover_date = data[7]
      line.save
    end

  end
end
