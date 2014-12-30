class Response < ActiveRecord::Base
  belongs_to :question
  belongs_to :answer_choice
end