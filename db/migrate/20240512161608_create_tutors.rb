# frozen_string_literal: true

class CreateTutors < ActiveRecord::Migration[7.1]
  def change
    create_table :tutors do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.integer :course_id
      t.timestamps
    end

    add_index :tutors, :email, unique: true
  end
end
