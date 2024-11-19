class CreateLines < ActiveRecord::Migration[7.1]
  def change
    create_table :lines do |t|
      t.integer :source, null: false
      t.integer :target, null: false
      # t.references :source, null: false, foreign_key: { to_table: :points }
      # t.references :target, null: false, foreign_key: { to_table: :points }

      t.timestamps
    end
  end
end
