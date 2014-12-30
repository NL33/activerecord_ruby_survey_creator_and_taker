class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
    	t.column :description, :string
    	t.column :questionID, :integer

    	t.timestamps
    end
  end
end
