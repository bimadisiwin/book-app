# frozen_string_literal: true

class AddColumnTitles < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :zip_code, :integer
    add_column :users, :address, :string
    add_column :users, :profile, :text
  end
end
