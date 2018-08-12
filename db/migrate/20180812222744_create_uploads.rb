class CreateUploads < ActiveRecord::Migration[5.2]
  def change
    create_table :uploads, id: :uuid do |t|
      t.timestamps
    end
  end
end
