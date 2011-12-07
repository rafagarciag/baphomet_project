class AddWhyUseToUsers < ActiveRecord::Migration
  def change
    add_column :users, :whyUse, :string
  end
end
