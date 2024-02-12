class CreateNices < ActiveRecord::Migration[6.1]
  def change
    create_table :nices do |t|
      t.integer :post_id,     null:false,  default: ""
      t.integer :user_id,     null:false,  default: ""
      t.string  :nice_status, null: false, default: ""
      t.timestamps
    end
  end
end
