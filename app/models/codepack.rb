class Codepack < ActiveRecord::Base
  belongs_to :deal
  has_many :codes
  attr_accessible :deal_id
end
