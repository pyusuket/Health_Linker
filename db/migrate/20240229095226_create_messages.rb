class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer :sender_id,   null: false, default: 0
      t.integer :receiver_id, null: false, default: 0
      t.text    :content,     null: false
      t.boolean :read,        null: false, default: false
      t.timestamps
    end
  end
end
