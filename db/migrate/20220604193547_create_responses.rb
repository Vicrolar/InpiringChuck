class CreateResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :responses do |t|
      t.references :request, null: false, foreign_key: true
      t.string :text

      t.timestamps
    end
  end
end
