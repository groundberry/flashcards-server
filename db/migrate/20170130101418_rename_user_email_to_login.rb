class RenameUserEmailToLogin < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :email, :login
  end
end
