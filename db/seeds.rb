# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(first_name: "Dude", last_name: "User", email: "user@example.com", password: "secret")
author = Admin.create(first_name: "Author", last_name: "Admin", email: "admin@example.com", password: "secret")

puts author.errors.messages

category_ruby = Category.create(title: "Ruby")
test_advanced_ruby = Test.new(title: "Advanced Ruby", level: 3, category_id: category_ruby.id, author_id: author.id)

q1 = Question.new(body: "What is the difference between lambda and proc?", test_id: test_advanced_ruby.id)
q2 = Question.new(body: "What is method_missig?", test_id: test_advanced_ruby.id)

q1.answers = [
    Answer.new(body: "There is no difference.", question_id: q1.id),
    Answer.new(body: "Lambda cares about number of arguments passed.", question_id: q1.id, correct: true),
    Answer.new(body: "Lambda is better on all counts.", question_id: q1.id),
    Answer.new(body: "Proc terminates currently executed function/method.", question_id: q1.id, correct: true),
]
q2.answers = [
    Answer.new(body: "This method is called when target method not defined.", question_id: q2.id, correct: true),
    Answer.new(body: "I don't know.", question_id: q2.id),
]
test_advanced_ruby.questions = [q1, q2]
test_advanced_ruby.save

category_sql = Category.create(title: "SQL")
category_ror = Category.create(title: "Ruby on Rails")
category_frontend = Category.create(title: "Frontend")
test_sql = Test.create(title: "SQL", level: 2, category_id: category_sql.id, author_id: author.id)
test_ror_basics = Test.create(title: "RoR Basics", level: 0, category_id: category_ror.id, author_id: author.id)
test_html_basics = Test.create(title: "HTML Basics", level: 0, category_id: category_frontend.id, author_id: user.id)
test_css_basics = Test.create(title: "CSS Basics", level: 0, category_id: category_frontend.id, author_id: user.id)
