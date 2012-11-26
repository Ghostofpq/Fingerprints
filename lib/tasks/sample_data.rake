namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
    make_actions
  end
end

def make_users
  admin = User.create!(name:     "Example User",
                       email:    "ex@am.ple",
                       password: "123456",
                       password_confirmation: "123456")
  admin.toggle!(:admin)
  10.times do |n|
    name  = Faker::Name.name
    email = "ex-#{n+1}@am.ple"
    password  = "123456"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_microposts
  users = User.all(limit: 6)
  15.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

def make_actions
  action1= Action.create(name: "Coffee",
                        category: "Social",
                        pic_path: "social/coffee.jpg")
  action2= Action.create(name: "Run",
                        category: "Sport",
                        pic_path: "sport/courir.jpg")
  
end