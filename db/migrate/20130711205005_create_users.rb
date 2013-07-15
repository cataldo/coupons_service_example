class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :balance

      t.timestamps
    end

    User.create name: "tester", balance: 0
  end
end
