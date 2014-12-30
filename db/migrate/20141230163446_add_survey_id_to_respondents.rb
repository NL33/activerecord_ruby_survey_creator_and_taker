class AddSurveyIdToRespondents < ActiveRecord::Migration
  def change
    add_column :respondents, :survey_id, :integer
  end
end
