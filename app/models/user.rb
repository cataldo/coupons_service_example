class User < ActiveRecord::Base
  has_many :orders
  has_many :coupons
  attr_accessible :balance, :name
end
