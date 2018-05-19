class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
      t.string :name
      t.integer :price
      t.integer :event_id, :index => true
      t.text :description
      t.timestamps
    end
  end
end
