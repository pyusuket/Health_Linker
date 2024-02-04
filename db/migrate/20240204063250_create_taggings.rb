class CreateTaggings < ActiveRecord::Migration[6.1]
  def change
    create_table :taggings do |t|
      t.string :name, null: false, default: ""
      t.timestamps
    end
  end
end
