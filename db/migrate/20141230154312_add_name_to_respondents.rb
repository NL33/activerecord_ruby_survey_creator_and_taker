class AddNameToRespondents < ActiveRecord::Migration
  def change
    add_column :respondents, :name, :string
  end
end
