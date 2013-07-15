class Order < ActiveRecord::Base
  belongs_to :deal
  belongs_to :coupon
  attr_accessible :deal_id, :paid_date, :state, :sum, :user_id

  state_machine :state, :initial => :not_paid do
    state :not_paid, :human_name => 'Не оплачен'
    state :paid, human_name: 'Оплачен'
    state :decline, human_name: 'Отменён'
    state :overdue, human_name: 'Просрочен'

    event :paid, :human_name => 'Оплатить' do
      transition not_paid: :paid
    end

    after_transition not_paid: :paid do |order, transition|
      @coupon = Coupon.create deal_id: order.deal_id, user_id: order.user_id
      @coupon.order = order
    end

  end




end
