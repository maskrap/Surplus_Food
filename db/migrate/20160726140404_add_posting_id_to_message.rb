class AddPostingIdToMessage < ActiveRecord::Migration
  def change
    add_column(:messages, :posting_id, :integer)
  end
end
