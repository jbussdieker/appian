class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :body
      t.integer :status
      t.text :state

      t.timestamps null: false
    end
  end
end
