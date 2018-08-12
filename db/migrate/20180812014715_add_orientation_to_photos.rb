class AddOrientationToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :orientation, :string, null: false
  end
end
