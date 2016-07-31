class TrunkLine < ApplicationRecord
  before_validation :reformat
  after_validation :format_full_address

  geocoded_by :full_address
  before_save :geocode

  protected
  def reformat
    self.respond_area = self.respond_area.delete(" ")
    self.address = self.address.delete(" ").delete("\r\n")
    self.dist = self.dist.delete(" ").delete(" ").delete("\r\n")
    self.vil = self.vil.delete(" ").delete(" ").delete("\r\n")
    self.around_time = self.around_time.delete(" ")
    self.recover_date =self.recover_date.delete(" ")
  end


  def format_full_address
    rex = get_address_regex
    full_address = self.dist + self.vil + self.address

    rex.each do |item|
      full_address.gsub!(item[:re],item[:rep])
    end

    full_address = process_end_address(full_address)

    self.full_address = full_address.strip
  end

  def process_end_address(addr)
    if (addr[-3..-2] == " 前" || addr[-3..-2] == "前 " || addr[-2] == "前" || addr[-1] == "前")
      addr.gsub!(/(前)/,"")
    end
    if (addr[-3..-2] == " 旁" || addr[-3..-2] == "旁 " || addr[-2] == "旁" || addr[-1] == "旁")
      addr.gsub!(/(旁)/,"")
    end
    addr
  end

  def get_address_regex
    rex = []
    rex.push({re: /(（|）|側門|對面|門口|迴轉|收至|結束|終站|貯坑|大門前|關音樂|沿路收|\(|\)|\+)/, rep: " "})
  	rex.push({re: /(前$|旁$)/, rep: " "})
  	rex.push({re: /(號前)/, rep: "號"})
  	rex.push({re: /(站旁)/, rep: "站"})
  	rex.push({re: /(與路|路口|路路口|路前|路旁|路底)/, rep: "路"})
  	rex.push({re: /(與街|街口|街街口|街前|街旁|街底)/, rep: "街"})
  	rex.push({re: /(與巷|巷口|巷巷口|巷前|巷旁|巷尾|巷底)/, rep: "巷"})
  	rex.push({re: /與弄|弄口|弄弄口|弄前|弄旁|弄底/, rep: "弄"})
    rex.push({re: /(三民西區|三民東區)/, rep: "三民區"})
  	rex.push({re: /(南鳳山區|北鳳山區)/, rep: "鳳山區"})
  	rex
  end
end
