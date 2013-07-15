class Code < ActiveRecord::Base
  belongs_to :codepack
  attr_accessible :code, :codepack_id, :user_id
end
