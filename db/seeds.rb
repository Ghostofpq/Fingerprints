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
##ROUTINE
Action.create(name: "Eat",
              category: "Routine",
              pic_path: "routine/eat.jpg",
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
##SPORTS 
Action.create(name: "Run",
              category: "Sports",
              pic_path: "sports/run.jpg",
              has_place: true)
Action.create(name: "Bike",
              category: "Sports",
              pic_path: "sports/bike.jpg",
              has_place: true)
Action.create(name: "Swim",
              category: "Sports",
              pic_path: "sports/swim.jpg",
              has_place: true)
Action.create(name: "Duel Sports",
              category: "Sports",
              pic_path: "sports/tennis.jpg",
              has_place: true)
Action.create(name: "Team Sports",
              category: "Sports",
              pic_path: "sports/basket.jpg",
              has_place: true)   
Action.create(name: "Fitness",
              category: "Sports",
              pic_path: "sports/fitness.jpg")  
##DUTY  
Action.create(name: "Dishwashing",
              category: "Duty",
              pic_path: "duty/dishwashing.jpg")
Action.create(name: "Supplies",
              category: "Duty",
              pic_path: "duty/supplies.jpg",
              has_price: true,
              has_place: true)
Action.create(name: "Housework",
              category: "Duty",
              pic_path: "duty/housework.jpg")   
Action.create(name: "Laundry",
              category: "Duty",
              pic_path: "duty/laundry.jpg")  
##LEISURE               
Action.create(name: "Take a walk",
              category: "Leisure",
              pic_path: "leisure/walk.jpg",
              has_place: true)  
Action.create(name: "Coffee",
              category: "Leisure",
              pic_path: "leisure/coffee.jpg",
              has_price: true,
              has_place: true,
              has_score: true,
              has_comment:true) 
Action.create(name: "Bar",
              category: "Leisure",
              pic_path: "leisure/bar.jpg",
              has_price: true,
              has_place: true,
              has_score: true,
              has_comment:true) 
Action.create(name: "Nightclub",
              category: "Leisure",
              pic_path: "leisure/nightclub.jpg",
              has_price: true,
              has_place: true,
              has_score: true,
              has_comment:true)                
Action.create(name: "Cinema",
              category: "Leisure",
              pic_path: "leisure/cinema.jpg",
              has_price: true,
              has_place: true,
              has_score: true,
              has_comment:true) 
Action.create(name: "Concert",
              category: "Leisure",
              pic_path: "leisure/concert.jpg",
              has_price: true,
              has_place: true,
              has_score: true,
              has_comment:true)             
Action.create(name: "Theatre",
              category: "Leisure",
              pic_path: "leisure/theatre.jpg",
              has_price: true,
              has_place: true,
              has_score: true,
              has_comment:true)             
Action.create(name: "Meet friends",
              category: "Leisure",
              pic_path: "leisure/friends.jpg",
              has_place: true) 
Action.create(name: "Movie",
              category: "Leisure",
              pic_path: "leisure/movie.jpg",
              has_score: true,
              has_comment:true) 
Action.create(name: "Video Games",
              category: "Leisure",
              pic_path: "leisure/videogames.jpg",
              has_score: true,
              has_comment:true) 
Action.create(name: "Board Games",
              category: "Leisure",
              pic_path: "leisure/boardgames.jpg",
              has_score: true,
              has_comment:true)           
Action.create(name: "Play an instrument",
              category: "Leisure",
              pic_path: "leisure/instrument.jpg") 


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



