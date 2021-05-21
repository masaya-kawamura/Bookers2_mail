class RenamePostcideColumnToPostcode < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :postcide, :postcode
  end
end
