class AddCheckboxesToPastebin < ActiveRecord::Migration
  def change
    add_column :pastebins, :editable, :boolean, :default => true
    add_column :pastebins, :visible, :boolean, :default => true
  end
end
