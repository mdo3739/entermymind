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