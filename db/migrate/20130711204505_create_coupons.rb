class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.integer :deal_id
      t.integer :user_id
      t.integer :code_id
      t.string :state
      t.datetime :use_date

      t.timestamps
    end
  end
end
