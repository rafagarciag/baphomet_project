class AddSyntaxToPastebin < ActiveRecord::Migration
  def change
    add_column :pastebins, :syntax, :string
  end
end
