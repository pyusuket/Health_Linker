class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer  :user_id,    null:false,  default: 0
      t.string   :body,       null: false, default: ""
      t.integer  :views_count,             default: 0
      t.timestamps
    end
  end
end
