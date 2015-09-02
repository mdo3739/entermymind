admin = User.new(
  username: 'Mike Deezy',
  email:    'admin@example.com',
  password: 'helloworld'
)
admin.skip_confirmation!
admin.save

4.times do
  user = User.new(
    username: Faker::Name.name,
    email:    Faker::Internet.safe_email,
    password: Faker::Lorem.characters(10)
  )
  user.skip_confirmation!
  user.save
end

User.all.each do |user|
  4.times do
    Topic.create(
      name: Faker::Commerce.department(1),
      user: user,
      public: true
    )
  end
end

Topic.all.each do |topic|
  5.times do
    Post.create(
      title:  Faker::Company.catch_phrase,
      body:   Faker::Hacker.say_something_smart,
      topic:  topic,
      public: true
    )
  end
end

puts "Seeding Complete"
puts "#{User.all.count} users in the database"
puts "#{Topic.all.count} topics in the database"
puts "#{Post.all.count} posts in the database"