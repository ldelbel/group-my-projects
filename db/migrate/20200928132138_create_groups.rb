class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.json :icon
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
