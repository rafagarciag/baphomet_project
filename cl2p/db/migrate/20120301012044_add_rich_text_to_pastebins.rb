class AddRichTextToPastebins < ActiveRecord::Migration
  def change
    add_column :pastebins, :richText, :string
  end
end
