#encoding: utf-8
class Deal < ActiveRecord::Base
  has_one :codepack
  has_many :coupons
  has_many :orders
  attr_accessible :coupons_count, :deadline, :descr, :discount, :full_cost, :max_coupons, :min_coupons,
                  :name, :price, :publication_time, :state, :type, :type_codes_generation, :list_codes
  attr_accessor :type_codes_generation, :list_codes


  after_create :set_codes

  validates :name, :min_coupons, :max_coupons, :price, :discount, :full_cost, presence: true

  state_machine :state, initial: :not_active do
    state :not_active, human_name: 'Не активна'
    state :active_not_success, human_name: 'Опубликована, но ещё не состоялась'
    state :active_success, human_name: 'Опубликована и состоялась'
    state :finish_fail, human_name: 'Не состоялась'
    state :finish_success, human_name: 'Состоялась'

    event :publish, human_name: 'Опубликовать' do
      transition not_active: :active_not_success
    end

    event :became_success, human_name: 'Стало успешным' do
      transition active_not_success: :active_success
    end

    event :finish_fail, human_name: 'Не состоялось' do
      transition active_not_success: :finish_fail
    end

    event :finish_success, human_name: 'Состоялось' do
      transition active_success: :finish_success
    end

    after_transition active_not_success: :active_success do |deal, transition|
      deal.coupons.each do | coupon |
        coupon.become_active
      end
    end

    after_transition active_not_success: :finish_fail do |deal, transition|
      deal.coupons.each do | coupon |
        coupon.become_overdue
      end
    end

    after_transition active_success: :finish_success do |deal, transition|
      deal.coupons.each do | coupon |
        coupon.become_not_used if coupon.active_not_use?
      end
    end
  end

  def profit
    ""
  end

  def can_buy_coupons?(user_id)
    coupon = self.coupons.where(user_id: user_id).first
    coupon.blank? and (active_not_success? or active_success?)
  end

  def get_code
    self.codepack.codes.where(coupon_id: nil).first
  end

  def check_coupons_count
    self.reload
    if self.coupons_count == self.min_coupons
      self.became_success
    elsif self.coupons_count == self.max_coupons
      self.finish_success
    end
  end

  def set_codes
    @codepack = Codepack.create deal_id: self.id
    if self.type_codes_generation == "generate"
      self.max_coupons.times do |i|
        Code.create codepack_id: @codepack.id, code: Digest::MD5.hexdigest("#{self.id} #{@codepack.id} #{Time.now}")[0..8]
      end
    elsif self.type_codes_generation == "load"
      self.list_codes.split(/\r?\n/).each do |code|
        Code.create codepack_id: @codepack.id, code: code
      end
    end
  end

end
