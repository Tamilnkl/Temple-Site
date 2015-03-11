class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :type
      t.attachment :pics
      t.timestamps
    end
  end
end
