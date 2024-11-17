class CreateLines < ActiveRecord::Migration[7.1]
  def change
    create_table :lines do |t|
      t.references :source, null: false, foreign_key: { to_table: :points }
      t.references :target, null: false,  foreign_key: { to_table: :points }

      t.timestamps
    end
  end
end
