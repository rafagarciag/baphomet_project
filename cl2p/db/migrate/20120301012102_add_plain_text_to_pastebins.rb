class AddPlainTextToPastebins < ActiveRecord::Migration
  def change
    add_column :pastebins, :plainText, :string
  end
end
