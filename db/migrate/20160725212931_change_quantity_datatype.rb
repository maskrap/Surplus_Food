class ChangeQuantityDatatype < ActiveRecord::Migration
  def change
    change_column :postings, :quantity, :string
  end
end
