class CreateCategories < ActiveRecord::Migration
  def change
    create_table(:categories) do |t|
      t.column(:name, :string)
    end
  end
end
