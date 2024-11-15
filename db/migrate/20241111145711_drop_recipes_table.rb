class DropRecipesTable < ActiveRecord::Migration[7.1]
  def up
    drop_table :recipes
  end

  def down
    # En el método `down`, puedes agregar el código para recrear la tabla si decides revertir la migración.
    create_table :recipes do |t|
      t.string :name
      t.text :description
      t.text :ingredients
      t.bigint :user_id
      t.timestamps
    end
  end
end
