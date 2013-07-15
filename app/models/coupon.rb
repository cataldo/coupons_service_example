class Coupon < ActiveRecord::Base
  belongs_to :deal, counter_cache: true
  belongs_to :user
  has_one :code
  has_one :order

  attr_accessible :deal_id, :state, :use_date, :user_id

  after_create :set_code
  after_create :check_coupons_count

  state_machine :state, :initial => :not_active do
    state :not_active, :human_name => 'Не активен'
    state :active_not_use, human_name: 'Ещё не использован'
    state :used, human_name: 'Использован'
    state :not_used, human_name: 'Не использован'
    state :overdue, human_name: 'Просрочен'


    event :use, :human_name => 'Использовать' do
      transition active_not_use: :used
    end

    event :become_active, :human_name => 'Сделать активным' do
      transition not_active: :active_not_use
    end

    event :become_overdue, :human_name => 'Акция не состоялась' do
      transition [:active_not_use, :not_active] => :overdue
    end

    event :become_not_used, :human_name => 'Акция состоялась, но купон не испольовали' do
      transition active_not_use: :not_used
    end


    after_transition not_active: :active_not_use do |coupon, transition|
      #send email with code
    end

    after_transition [:active_not_use, :not_active] => :not_used do |coupon, transition|
      #send email
    end

    after_transition [:active_not_use, :not_active] => :overdue do |coupon, transition|
      #send email
      coupon.user.balance += coupon.order.sum
      coupon.user.save
    end


  end

  def set_code
    self.code = self.deal.get_code
  end

  def check_coupons_count
    self.deal.check_coupons_count
    if self.deal.active_success? or self.deal.finish_success? # чтобы не потерялся последний купон
      self.become_active
    end
  end

  def show_code
    self.code.code if self.active_not_use?
  end

end
