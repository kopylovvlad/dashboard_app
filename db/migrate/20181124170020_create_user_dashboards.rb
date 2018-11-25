class CreateUserDashboards < ActiveRecord::Migration[5.1]
  def change
    create_table :user_dashboards do |t|
      t.integer :user_id, index: true
      t.string :title, null: false, default: ''
      t.integer :position, default: 0
      t.timestamps
    end
    add_foreign_key :user_dashboards, :users
  end
end
