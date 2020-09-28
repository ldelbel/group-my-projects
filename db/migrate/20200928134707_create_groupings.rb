class CreateGroupings < ActiveRecord::Migration[6.0]
  def change
    create_table :groupings do |t|
      t.references :group, foreign_key: true
      t.references :project, foreign_key: true
      t.timestamps
    end
  end
end
