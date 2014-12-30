class AnswerChoice < ActiveRecord::Base
 belongs_to :question
 has_many :responses
end