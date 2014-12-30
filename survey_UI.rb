require 'active_record'
require './lib/survey'
require './lib/question'
require './lib/respondent'
require './lib/answer_choice'
require './lib/response'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "Survey System.\n\n"
  menu
end

def menu
  choice = nil
  until choice == 'x'
  puts "Welcome!\n" 
  puts "Press 'a' to create a survey;
  Press 'b' to take a survey;
  Press 'c' to view survey results;
  Press 'd' to create a survey with multiple valid responses per question
  press x to exit" 
 
 
  choice = gets.chomp
  case choice
  when 'a'
	create_survey
  when 'b'
   take_survey
  when 'c'
    view_results
  when 'x'
   puts "Good-bye!"
   exit

  else
    puts "Sorry, that wasn't a valid option."
  end
end 
end

def create_survey
puts "Please provide the name of your survey"
  survey_name = gets.chomp
  survey = Survey.new({:name => survey_name})
  if !survey.save 
      puts "Please enter a name for your survey"
      create_survey
  else
      survey.save
  end
  loop do
    puts "Please enter a new number for a new survey question"
    number_entry = gets.chomp
    puts "Please enter the question"
    question_entry = gets.chomp
    question = Question.new({:survey_id => survey.id, :number => number_entry, :description => question_entry})
    question.save
    loop do
      puts "Please provide the letter of an answer to this question"
      answer_letter = gets.chomp
      puts "Please provide the text of this answer choice"
      answer_description = gets.chomp
      answer = AnswerChoice.new({:question_id => question.id, :letter => answer_letter, :description => answer_description})
      answer.save
      puts "Would you like to enter another answer choice for this question? (y/n)"
      break if gets.chomp == 'n'
     end
    puts "Would you like to enter another question? (y/n)"
    break if gets.chomp == 'n'
   end
   puts "\n Thank you. Your survey has been recorded. You will now return to the main menu. \n \n"
end

def take_survey
 puts "please enter your name"
   name = gets.chomp
 puts "Enter the name of the survey you are going to take\n"
  survey_name = gets.chomp
 survey = Survey.where({:name => survey_name}).first
 respondent = Respondent.new({:name => name, :survey_id => survey.id})
 respondent.save
 puts "\n Thank you. Your survey will now begin \n \n"
 
 survey.questions.each do |question|
  puts "#{question.number}: #{question.description}"
  puts "Answer choices:"
  question.answer_choices.each do |answer_choice|
    puts "#{answer_choice.letter}: #{answer_choice.description}"
    end
    puts "Please select your answer"
    selected_answer = gets.chomp
    answer_choice = AnswerChoice.where({:question_id => question.id, :letter => selected_answer}).first
    response = Response.new({:question_id => question.id, :description => selected_answer, :answer_choice_id => answer_choice.id})
    response.save
  end
 puts "\n\n Thank you.  Your responses have been recorded. \n\n"
end
    
    
def view_results
puts "Enter the name of the survey the results of which you want to view"
survey_name = gets.chomp
survey = Survey.where({:name => survey_name}).first
puts "Here are the number of people who took this survey \n"
respondent_number = survey.respondents.count
puts respondent_number
puts "\nHere are the number of people who selected each answer \n \n"
  survey.questions.each do |question|
    puts "#{question.number}: #{question.description}"
    question.answer_choices.each do |answer_choice|
        puts "#{answer_choice.letter}: #{answer_choice.description}. #{answer_choice.responses.count} people selected this answer \n\n"          
    end
 end

puts "Here are the percentage of people who selected each answer\n \n"
  survey.questions.each do |question|
    puts "#{question.number}: #{question.description}"
    question.answer_choices.each do |answer_choice|
      percent = (answer_choice.responses.count.to_f / respondent_number.to_f)
        puts "#{answer_choice.letter}: #{percent.to_s.delete "0."}% \n"
    end
 end
puts "\nYou will now be brought back to the main menu \n"
end


welcome