class CreateRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :requests do |t|
      t.string :request_type
      t.string :word
      t.string :category

      t.timestamps
    end
  end
end
