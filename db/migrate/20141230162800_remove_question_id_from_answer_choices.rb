class RemoveQuestionIdFromAnswerChoices < ActiveRecord::Migration
  def change
    remove_column :answer_choices, :questionID, :integer
  end
end
