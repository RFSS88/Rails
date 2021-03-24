class CreateToys < ActiveRecord::Migration
  def change
    create_table :toys do |t|
      t.integer :cat_id, null: false
      t.string :name, null: false
      t.string :ttype, null: false
      # we can not use 'type' as a column name. ActiRecord won't allow it.
      # using 'ttype' to get around that. 

      t.timestamps
    end
  end
end
