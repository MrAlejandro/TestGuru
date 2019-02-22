# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(name: "Dude")

category_ruby = Category.create(title: "Ruby")
category_sql = Category.create(title: "SQL")
category_ror = Category.create(title: "Ruby on Rails")

test_advanced_ruby = Test.create(title: "Advanced Ruby", level: 3, category_id: category_ruby.id)
test_sql = Test.create(title: "SQL", level: 2, category_id: category_sql.id)
test_ror_basics = Test.create(title: "RoR Basics", level: 0, category_id: category_ror.id)
test_html_basics = Test.create(title: "HTML Basics", level: 0)
test_css_basics = Test.create(title: "CSS Basics", level: 0)

advanced_ruby_questions = Question.create(
  [
    {body: "What is the difference between lambda and proc?", test_id: test_advanced_ruby.id},
    {body: "What is method_missig?", test_id: test_advanced_ruby.id},
  ]
)
advanced_ruby_answers = Answer.create(
  [
    {body: "There is no difference.", question_id: advanced_ruby_questions[0].id},
    {body: "Lambda cares about number of arguments passed.", question_id: advanced_ruby_questions[0].id, correct: true},
    {body: "This method is called when target method not defined.", question_id: advanced_ruby_questions[1].id, correct: true},
    {body: "I don't know.", question_id: advanced_ruby_questions[1].id},
  ]
)

TestResult.create(user_id: user.id, test_id: test_advanced_ruby.id, score: 0.0)
TestResult.create(user_id: user.id, test_id: test_advanced_ruby.id, score: 33.33, status: :complete)
TestResult.create(user_id: user.id, test_id: test_advanced_ruby.id, score: 55.55, status: :complete)
TestResult.create(user_id: user.id, test_id: test_advanced_ruby.id, score: 77.77, status: :complete)
