class CreateTaggings < ActiveRecord::Migration[6.1]
  def change
    create_table :taggings do |t|
      t.integer :post_id, null:false,  default: "",unique: true
      t.integer :tag_id,  null:false,  default: "",unique: true
      t.string  :name,    null: false, default: ""
      t.timestamps
    end
  end
end
