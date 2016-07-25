class CreatePostings < ActiveRecord::Migration
  def change
    create_table(:postings) do |t|
      t.column(:user_id, :integer)
      t.column(:description, :string)
      t.column(:source_type, :string)
      t.column(:quantity, :integer)
      t.column(:location, :string)

      t.timestamps()
    end
  end
end
