class CreateTargets < ActiveRecord::Migration[5.1]
  def change
    create_table :targets do |t|
      t.float :latitude
      t.float :longitude
      t.integer :radius
      t.string :title

      t.timestamps
    end
  end
end
