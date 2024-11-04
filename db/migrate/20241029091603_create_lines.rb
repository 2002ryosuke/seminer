class CreateLines < ActiveRecord::Migration[7.1]
  def change
    create_table :lines do |t|
      t.string :source
      t.string :target

      t.timestamps
    end
  end
end
