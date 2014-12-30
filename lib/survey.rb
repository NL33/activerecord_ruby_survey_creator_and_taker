class Survey < ActiveRecord::Base
  validates :name, :presence => true
  
  has_many :questions
  has_many :respondents
end