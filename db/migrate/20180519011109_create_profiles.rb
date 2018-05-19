class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id, :index => true
      t.string :legal_name
      t.string :location
      t.string :education
      t.string :occupation
      t.date :birthday
      t.text :bio
      t.text :specialty
      t.timestamps
    end
  end
end
