class CreateNices < ActiveRecord::Migration[6.1]
  def change
    create_table :nices do |t|
      t.string :nice_status, null: false, default: ""
      t.timestamps
    end
  end
end
