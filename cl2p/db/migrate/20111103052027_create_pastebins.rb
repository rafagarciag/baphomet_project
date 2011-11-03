class CreatePastebins < ActiveRecord::Migration
  def change
    create_table :pastebins do |t|
      t.string :url
      t.string :content

      t.timestamps
    end
  end
end
