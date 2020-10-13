class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :time_spent
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
