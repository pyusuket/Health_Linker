class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer  :user_id, null: false, default: ""
      t.text     :content, null: false, default: ""
      t.boolean  :read,    null: false, default: "false"
      t.timestamps
    end
  end
end
