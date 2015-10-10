admin = User.new(
  username: 'Mike Deezy',
  email:    'admin@example.com',
  password: 'helloworld',
  role:     'Da Boss'
)
admin.skip_confirmation!
admin.save

user = User.new(
  username: 'Member',
  email:    'member@example.com',
  password: 'helloworld',
  role:     'member'
)
user.skip_confirmation!
user.save

3.times do
  user = User.new(
    username: Faker::Name.name,
    email:    Faker::Internet.safe_email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save
end

User.all.each do |user|
  2.times do
    Topic.create!(
      name: Faker::Commerce.department(1),
      user: user,
      public: true
    )
  end
end

Topic.all.each do |topic|
  5.times do
    Post.create!(
      title:  Faker::Company.catch_phrase,
      body:   Faker::Lorem.paragraph(5),
      topic:  topic,
      public: true,
      created_at: Faker::Date.backward(7)
    )
  end
end

Post.all.each do |post|
  3.times do
    Comment.create!(
      user: User.all.sample,
      post: post,
      body: Faker::Hacker.say_something_smart,
      created_at: Faker::Date.backward(14)
    )
  end
end

choice = [-1, 1]
Post.all.each do |post|
  User.all.each do |user|
    Vote.create!(
      user: user,
      post: post,
      value: choice.sample
    )
  end
end

puts "Seeding Complete"
puts "#{User.all.count} users in the database"
puts "#{Topic.all.count} topics in the database"
puts "#{Post.all.count} posts in the database"
puts "#{Comment.all.count} comments in the database"
puts "#{Vote.all.count} votes created"