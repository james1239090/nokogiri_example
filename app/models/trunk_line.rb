class TrunkLine < ApplicationRecord
  before_validation :reformat


  protected
  def reformat
    self.respond_area = self.respond_area.delete(" ")
    self.address = self.address.delete(" ").delete("\r\n")
    self.dist = self.dist.delete(" ").delete(" ").delete("\r\n")
    self.vil = self.vil.delete(" ").delete(" ").delete("\r\n")
    self.around_time = self.around_time.delete(" ")
    self.recover_date =self.recover_date.delete(" ")
  end
end
