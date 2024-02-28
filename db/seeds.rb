# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Delete models
Answer.delete_all
Question.delete_all
TestAttempt.delete_all
Test.delete_all
User.delete_all
Category.delete_all

# Users
users = User.create([{ first_name: 'Jack', last_name: 'Sparrow', email: 'Jack.Sparrow@carribean.sea'},
                     { first_name: 'Will', last_name: 'Turner', email: 'Will.Turner@carribean.sea'},
                     { first_name: 'Captain', last_name: 'Barbossa', email: 'Captain.Barbossa@carribean.sea'},
                     { first_name: 'Elizabeth', last_name: 'Swann', email: 'Elizabeth.Swann@carribean.sea'}])

# Categories

frontend = Category.create(title: 'Frontend')
backend = Category.create(title: 'Backend')
database = Category.create(title: 'Databases')

# Tests

tests = Test.create([{ title: 'HTML', level: 0, category_id: frontend.id, author_id: User.first(2).pluck(:id).sample },
                     { title: 'CSS', level: 1, category_id: frontend.id, author_id: User.first(2).pluck(:id).sample },
                     { title: 'Javascript', level: 4, category_id: frontend.id, author_id: User.first(2).pluck(:id).sample },
                     { title: 'Ruby', level: 2, category_id: backend.id, author_id: User.first(2).pluck(:id).sample },
                     { title: 'C#', level: 3, category_id: backend.id, author_id: User.first(2).pluck(:id).sample },
                     { title: 'Node JS', level: 3, category_id: backend.id, author_id: User.first(2).pluck(:id).sample },
                     { title: 'PostgreSQL', level: 2, category_id: database.id, author_id: User.first(2).pluck(:id).sample },
                     { title: 'MS SQL', level: 3, category_id: database.id, author_id: User.first(2).pluck(:id).sample },
                     { title: 'MongoDB', level: 4, category_id: database.id, author_id: User.first(2).pluck(:id).sample }])

# Questions and Answers (10 questions with 4 answers and the only correct)
tests.each do |t|
  10.times do | i |
    q = Question.create( body: "Question # #{i+1}", test_id: t.id)
    has_correct = false
    4.times do |j|
      correct = false
      unless has_correct
        correct = [true, false].sample
        has_correct = true if correct == true
      end
      correct = true if j==4 and has_correct
      Answer.create( body: "answer #{j+1}", correct: correct, question_id: q.id)
    end
  end
end

# Test attempts
tests.each do |test|
  users.each do |user|
    status = [:started, :finished].sample
    result = [:positive, :negative].sample
    TestAttempt.create(status: status, result: result, user_id: user.id, test_id: test.id) if [true, false].sample
  end
end