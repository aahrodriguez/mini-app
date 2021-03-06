# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
#Adm user with example tasks
adm = User.create(email: 'adm@email.com', password: '123123')
for i in 0..2 do
  task = Task.create(title: "Example Task \##{i + 1}", description: 'A Task can have a description of up to 280 characters!', priority: (10*i), user: adm, status: 10, share: true)
  Comment.create(body: "This Example Task \##{7 - i} has one Example Comment!", task: task, user: adm)
end

#Normal user 1
user = User.create(email: 'a@b.c', password: '123123')
task = Task.create(title: 'Organize Class Trial', description: 'Help organize my classmates for a class debate', priority: 20, user: user, share: true, status: 10)
comment = Comment.create(body: "I'll help you out", task: task, user: adm)


#Normal user 2
user = User.create(email: '1@2.3', password: '123123')

Task.create(title: 'Escape room', description: 'I want to try the new Escape Room in town', priority: 10, user: user, share: true)
comment.update(score: 2)
Pluse.create(comment: comment, user: adm)
Pluse.create(comment: comment, user: user)

path_adm = Rails.root.join 'app', 'assets', 'images', 'test-update.png'
Profile.create(nickname: 'Mukuro', bio: 'Just your administration User', user: adm, share: true).avatar.attach(io: File.open(path_adm), filename: "test-update.png")
=begin
path_user = Rails.root.join 'app', 'assets', 'images', 'test-image.png'
Profile.create(nickname: 'Junko', bio: 'Just your normal User number 1', user: user).avatar.attach(io: File.open(path_user), filename: "test-image.png")

p adm
path_user = Rails.root.join 'app', 'assets', 'images', 'test-image.png'
Profile.create(nickname: 'Nagito', bio: 'Just your normal User number 2', user: user).avatar.attach(io: File.open(path_user), filename: "test-image.png")
=end

