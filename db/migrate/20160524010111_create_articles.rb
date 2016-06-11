class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.references :author, index: true, foreign_key: true#trying to add one to many relationship of 1 author and many articles

      t.timestamps null: false
    end
  end
end
