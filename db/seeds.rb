# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1=User.create(name: "user1",email: "ex@amp.le",password: "123456",password_confirmation: "123456")
user2=User.create(name: "user2",email: "ex2@amp.le",password: "123456",password_confirmation: "123456")

user1.follow!(user2)
user2.follow!(user1)

Action.create(name: "Eat",
              category: "Routine",
              pic_path: "routine/eat.jpg",
              has_duration: true,
              has_price: true,
              has_place: true,
              has_score: true,
              has_comment:true)         
Action.create(name: "Sleep",
              category: "Routine",
              pic_path: "routine/sleep.jpg")         
Action.create(name: "Wash",
              category: "Routine",
              pic_path: "routine/wash.jpg")
Action.create(name: "Work",
              category: "Routine",
              pic_path: "routine/work.jpg")
Action.create(name: "Study",
              category: "Routine",
              pic_path: "routine/study.jpg")                     
Action.create(name: "Coffee",
              category: "Social",
              pic_path: "social/coffee.jpg",
              has_price: true) 
Action.create(name: "Run",
              category: "Sports",
              pic_path: "sports/run.jpg")
Action.create(name: "Bike",
              category: "Sports",
              pic_path: "sports/bike.jpg")
Action.create(name: "Swim",
              category: "Sports",
              pic_path: "sports/swim.jpg")
Action.create(name: "Duel Sports",
              category: "Sports",
              pic_path: "sports/tennis.jpg")
Action.create(name: "Team Sports",
              category: "Sports",
              pic_path: "sports/basket.jpg")   
Action.create(name: "Fitness",
              category: "Sports",
              pic_path: "sports/fitness.jpg")  

Achievement.create(name: "Sleep10h",
              pic_path: "routine/sleep.jpg")
Achievement.create(name: "Sleep12h",
              pic_path: "routine/sleep.jpg")
Achievement.create(name: "Sleep14h",
              pic_path: "routine/sleep.jpg")              
Achievement.create(name: "Sleep_c_1D",
              pic_path: "routine/sleep.jpg")
Achievement.create(name: "Sleep_c_1W",
              pic_path: "routine/sleep.jpg")
Achievement.create(name: "Sleep_c_1M",
              pic_path: "routine/sleep.jpg")
Action.find_by_name("Sleep").references!(Achievement.find_by_name("Sleep10h"))
Action.find_by_name("Sleep").references!(Achievement.find_by_name("Sleep12h"))
Action.find_by_name("Sleep").references!(Achievement.find_by_name("Sleep14h"))
Action.find_by_name("Sleep").references!(Achievement.find_by_name("Sleep_c_1D"))
Action.find_by_name("Sleep").references!(Achievement.find_by_name("Sleep_c_1W"))
Action.find_by_name("Sleep").references!(Achievement.find_by_name("Sleep_c_1M"))



