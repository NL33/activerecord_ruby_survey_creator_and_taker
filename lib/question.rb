class Question < ActiveRecord::Base
  #validates :description, :presence => true
  
  belongs_to :survey
  has_many :answer_choices
  has_many :responses, through: :answer_choices
end