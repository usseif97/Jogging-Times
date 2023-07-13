class CreateJogs < ActiveRecord::Migration[7.0]
  def change
    create_table :jogs do |t|
      t.date :date
      t.integer :distance
      t.integer :time
      t.references :user, null: false, foreign_key:   

      t.timestamps
    end
  end
end
