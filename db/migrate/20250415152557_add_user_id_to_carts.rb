class AddUserIdToCarts < ActiveRecord::Migration[6.1]  # Use your Rails version here
  def change
    # Add user_id as a nullable foreign key
    add_reference :carts, :user, null: true, foreign_key: true
  end
end