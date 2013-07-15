class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :name
      t.text :descr
      t.integer :max_coupons
      t.integer :min_coupons
      t.datetime :publication_time
      t.datetime :deadline
      t.string :type
      t.integer :coupons_count
      t.integer :price
      t.integer :discount
      t.integer :full_cost
      t.string :state

      t.timestamps
    end
  end
end
