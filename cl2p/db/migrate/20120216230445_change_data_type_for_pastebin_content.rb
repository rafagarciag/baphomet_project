class ChangeDataTypeForPastebinContent < ActiveRecord::Migration
  def up
	change_table :pastebins do |t|
		t.change :content, :blob
	end
  end

  def down
	change_table :pastebins do |t|
		t.change :content, :string
	end
  end
end
