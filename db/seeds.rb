User.create! name:  "Example User",
  email: "example@railstutorial.org",
  password: "foobar",
  password_confirmation: "foobar",
  admin: true,
  active: true,
  activated_at: Time.zone.now

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create! name: name,
    email: email,
    password: password,
    password_confirmation: password,
    active: true,
    activated_at: Time.zone.now
end

users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each {|followed| user.follow followed}
followers.each {|follower| follower.follow user}

10.times do |n|
  name = Faker::Name.title
  content = Faker::Lorem.paragraph
  Category.create! name: name, content: content
  40.times do |n2|
    content = Faker::Lorem.word
    category_id = n+1
    Word.create! content: content, category_id: category_id
    Answer.create! correct: true, content: Faker::Lorem.word, word_id: n2+1
    3.times do |n1|
      correct = false
      content = Faker::Lorem.word
      word_id = n2+1
      Answer.create! correct: correct, content: content, word_id: word_id
    end
  end
end

word_count = 0

30.times do |n| 
  word_count+=1
  correct_total = rand(1..20)
  user_id = rand(1..100)
  category_id = rand(1..10)
  Lesson.create! correct_total: correct_total,user_id: user_id, category_id: category_id
  20.times do |n1|
    word_id = word_count
    answer = Answer.find_by word: word_id
    lesson_id = n+1
    Result.create! word_id: word_id, answer_id: answer.id, lesson_id: lesson_id
  end
end
