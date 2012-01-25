class AddForeignKeyToPastebins < ActiveRecord::Migration
  def change
    add_column :pastebins, :user_id, :integer
  end
end
