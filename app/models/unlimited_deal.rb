class UnlimitedDeal < Deal

  def profit
    if self.full_cost?
      "до #{self.full_cost * self.discount / 100}"
    else
      "не ограниченна"
    end
  end
end
