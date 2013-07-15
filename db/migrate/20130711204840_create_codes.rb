class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.integer :codepack_id
      t.string :code
      t.integer :coupon_id

      t.timestamps
    end
  end
end
