class FixedDeal < Deal

  def profit
    self.full_cost - ( self.full_cost * self.discount / 100  + self.price)
  end
end
