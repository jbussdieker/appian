class CreateDeployments < ActiveRecord::Migration
  def change
    create_table :deployments do |t|
      t.string :name
      t.integer :project_id
      t.text :variables
      t.text :output
      t.integer :status
      t.text :state

      t.timestamps null: false
    end
  end
end
