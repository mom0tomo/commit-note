class CreateCommits < ActiveRecord::Migration[5.2]
  def change
    create_table :commits do |t|
      t.integer :number
      t.integer :day
      t.references :user, foreign_key: true
      t.references :month, foreign_key: true

      t.timestamps
    end
  end
end
