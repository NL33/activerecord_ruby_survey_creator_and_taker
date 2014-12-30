class AddAnswerChoiceIdToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :answer_choice_id, :integer
  end
end
