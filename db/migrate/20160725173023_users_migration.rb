class UsersMigration < ActiveRecord::Migration
  def change
    create_table :users do | t |
      t.string  :name
      t.string  :password_digest
      t.timestamps
    end

    create_table :messages do | t |
      t.string  :subject
      t.string  :body
      t.boolean :sent
      t.timestamps
    end
  end
end
