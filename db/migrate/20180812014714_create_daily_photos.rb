class CreateDailyPhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :daily_photos, id: :uuid do |t|
      t.date :date, null: false
      t.belongs_to :photo, type: :uuid, index: true
      t.timestamps
    end
  end
end
