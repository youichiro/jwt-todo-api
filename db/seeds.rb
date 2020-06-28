User.create!(
  name: 'admin',
  email: 'admin@gmail.com',
  password: 'password'
)

5.times do |i|
  Task.create!(
    user: User.first,
    title: "Task#{i}",
    done: i % 2 == 0 ? true : false
  )
end
