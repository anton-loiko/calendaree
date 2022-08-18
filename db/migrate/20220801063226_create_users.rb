class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, index: { unique: true }
      t.string :name
      t.string :avatar
      t.string :discord_username
      t.integer :work_time, null: false, default: 8
      t.float :remaining_days
      t.boolean :admin, null: false, default: false

      t.timestamps
    end
  end
end
