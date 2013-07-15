class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :deal_id
      t.integer :sum
      t.string :state
      t.datetime :paid_date

      t.timestamps
    end
  end
end
