class CreateCodepacks < ActiveRecord::Migration
  def change
    create_table :codepacks do |t|
      t.integer :deal_id

      t.timestamps
    end
  end
end
