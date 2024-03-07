class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.integer  :user_id, null: false, default: 0
      t.string :title
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
