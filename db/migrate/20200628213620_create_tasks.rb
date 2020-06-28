class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false, limit: 100
      t.boolean :done, null: false, default: false

      t.timestamps
    end
  end
end
