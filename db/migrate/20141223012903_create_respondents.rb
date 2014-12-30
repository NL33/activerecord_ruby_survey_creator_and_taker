class CreateRespondents < ActiveRecord::Migration
  def change
    create_table :respondents do |t|
    	t.column :description, :string
    	t.column :surveyID, :integer

    	t.timestamps
    end
  end
end
