class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :sender_id,   null: false, default: ""
      t.integer :receiver_id, null: false, default: ""
      t.text    :content,     null: false, default: ""
      t.boolean :read,        null: false, default: "false"
      t.timestamps
    end
  end
end
