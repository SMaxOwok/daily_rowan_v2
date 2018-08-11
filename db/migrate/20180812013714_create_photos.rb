class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos, id: :uuid do |t|
      t.integer :daily_photos_count, default: 0, null: false
      t.integer :dimensions, default: [], array: true, null: false
      t.timestamps
    end
  end
end
