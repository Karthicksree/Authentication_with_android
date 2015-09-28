class AddMobileNumberToUser < ActiveRecord::Migration
  def change
    add_column :users, :mobile_number, :integer
    add_column :users, :gender, :integer
  end
end
