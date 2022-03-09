class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :name
      t.string :nationality
      t.date :birthday
      t.integer :points, :null => false, :default => 1200

      t.timestamps
    end
    add_index :players, :name, unique: true
  end
end
