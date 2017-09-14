class SearchAnalytic < ApplicationRecord
  after_initialize :set_quantity

  def set_quantity
    self.quantity ||= 0 # 0 if not already set
  end
end
