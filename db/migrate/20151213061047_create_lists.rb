class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.belongs_to :user
      t.string :name
      t.string :description
      t.string :url
      t.string :price

      t.timestamps
    end
  end
end
