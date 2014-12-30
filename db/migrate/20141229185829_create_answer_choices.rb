class CreateAnswerChoices < ActiveRecord::Migration
  def change
    create_table :answer_choices do |t|
    	t.column :description, :string
    	t.column :questionID, :integer
    	t.column :letter, :string

    	t.timestamps
    end
  end
end
