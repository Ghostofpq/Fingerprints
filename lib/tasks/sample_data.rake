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
  actionV1= Action.create(name: "Manger",
                        category: "Vie",
                        pic_path: "vie/manger.jpg")
  actionV2= Action.create(name: "Dormir",
                        category: "Vie",
                        pic_path: "vie/dormir.jpg")
  actionV3= Action.create(name: "Se laver",
                        category: "Vie",
                        pic_path: "vie/hygiene.jpg")
  actionV4= Action.create(name: "Travailler",
                        category: "Vie",
                        pic_path: "vie/travailler.jpg")
  actionV5= Action.create(name: "Etudier",
                        category: "Vie",
                        pic_path: "vie/etudier.jpg") 
                        
  action1= Action.create(name: "Coffee",
                        category: "Social",
                        pic_path: "social/coffee.jpg") 
  
  
  actionS1= Action.create(name: "Run",
                        category: "Sport",
                        pic_path: "sport/courir.jpg")
  actionS2= Action.create(name: "Velo",
                        category: "Sport",
                        pic_path: "sport/velo.jpg")
  actionS3= Action.create(name: "Piscine",
                        category: "Sport",
                        pic_path: "sport/piscine.jpg")
  actionS4= Action.create(name: "Sport de duel",
                        category: "Sport",
                        pic_path: "sport/tennis.jpg")
  actionS5= Action.create(name: "Sport de d'equipe",
                        category: "Sport",
                        pic_path: "sport/basket.jpg")   
  actionS6= Action.create(name: "Muscu",
                        category: "Sport",
                        pic_path: "sport/muscu.jpg")                                                                        
end