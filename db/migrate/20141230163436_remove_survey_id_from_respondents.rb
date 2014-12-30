class RemoveSurveyIdFromRespondents < ActiveRecord::Migration
  def change
    remove_column :respondents, :surveyID, :integer
  end
end
