class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name
      t.string :type
      t.text :configuration

      t.timestamps null: false
    end
  end
end
