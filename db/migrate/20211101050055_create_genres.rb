class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|

      t.timestamps
      t.string :name, null: false, default: ""
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
