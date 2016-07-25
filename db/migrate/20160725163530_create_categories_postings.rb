class CreateCategoriesPostings < ActiveRecord::Migration
  def change
    create_table(:categories_postings) do |t|
      t.column(:category_id, :integer)
      t.column(:posting_id, :string)
    end
  end
end
