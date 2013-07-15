class CertificateDeal < Deal

  def profit
    self.full_cost - self.price
  end

end
