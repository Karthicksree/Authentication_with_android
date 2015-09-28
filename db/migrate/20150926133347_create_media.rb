class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.attachment :attachment
      t.references :post, index: true
      t.references :comment, index: true

      t.timestamps null: false
    end
    add_foreign_key :media, :posts
    add_foreign_key :media, :comments
  end
end
