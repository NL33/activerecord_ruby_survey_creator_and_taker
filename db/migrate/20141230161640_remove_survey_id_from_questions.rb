class RemoveSurveyIdFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :surveyID, :integer
  end
end
