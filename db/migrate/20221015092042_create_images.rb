class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images, id: :uuid do |t|
      t.string :email, null: false
      
      t.timestamps
    end
  end
end
