# frozen_string_literal: true

class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :organizations, :name, unique: true
  end
end
