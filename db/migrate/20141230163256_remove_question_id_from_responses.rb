class RemoveQuestionIdFromResponses < ActiveRecord::Migration
  def change
    remove_column :responses, :questionID, :integer
  end
end
