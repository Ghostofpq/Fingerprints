# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1=User.create(name: "user1",email: "ex@amp.le",password: "123456",password_confirmation: "123456")
user2=User.create(name: "user2",email: "ex2@amp.le",password: "123456",password_confirmation: "123456")
admin=User.create(name: "admin",email: "ad@mi.n",password: "123456",password_confirmation: "123456")
admin.admin=true
user1.save!
user2.save!
admin.save!
user1.follow!(user2)
user2.follow!(user1)
##ROUTINE
Activity.create(name: "Eat",
              past_participle: "eaten",
              category: "Routine",
              pic_path: "routine/eat.jpg",
              has_price: true,
              has_place: true,
              has_score: true,
              has_comment:true).save!        
Activity.create(name: "Sleep",
              past_participle: "slept",
              category: "Routine",
              pic_path: "routine/sleep.jpg").save!         
Activity.create(name: "Wash",
              past_participle: "washed myself",
              category: "Routine",
              pic_path: "routine/wash.jpg").save!
Activity.create(name: "Work",
              past_participle: "worked",
              category: "Routine",
              pic_path: "routine/work.jpg").save!
Activity.create(name: "Study",
              past_participle: "studied",
              category: "Routine",
              pic_path: "routine/study.jpg").save!                     
##SPORTS 
Activity.create(name: "Run",
              past_participle: "run",
              category: "Sports",
              pic_path: "sports/run.jpg",
              has_place: true).save!
Activity.create(name: "Bike",
              past_participle: "cycled",
              category: "Sports",
              pic_path: "sports/bike.jpg",
              has_place: true).save!
Activity.create(name: "Swim",
              past_participle: "swum",
              category: "Sports",
              pic_path: "sports/swim.jpg",
              has_place: true).save!
Activity.create(name: "Duel Sports",
              past_participle: "played duel sport",
              category: "Sports",
              pic_path: "sports/tennis.jpg",
              has_place: true).save!
Activity.create(name: "Team Sports",
              past_participle: "played team sport",
              category: "Sports",
              pic_path: "sports/basket.jpg",
              has_place: true).save!   
Activity.create(name: "Fitness",
              past_participle: "exercised",
              category: "Sports",
              pic_path: "sports/fitness.jpg")  
##DUTY  
Activity.create(name: "Dishwashing",
              past_participle: "done the dishes",
              category: "Duty",
              pic_path: "duty/dishwashing.jpg").save!
Activity.create(name: "Supplies",
              past_participle: "bought the supplies",
              category: "Duty",
              pic_path: "duty/supplies.jpg",
              has_price: true,
              has_place: true).save!
Activity.create(name: "Housework",
              past_participle: "done the houseworks",
              category: "Duty",
              pic_path: "duty/housework.jpg").save!   
Activity.create(name: "Laundry",
              past_participle: "done the laundry",
              category: "Duty",
              pic_path: "duty/laundry.jpg").save!  
##LEISURE               
Activity.create(name: "Take a walk",
              past_participle: "walked",      
              category: "Leisure",
              pic_path: "leisure/walk.jpg",
              has_place: true).save!  
Activity.create(name: "Coffee",
              past_participle: "been to a coffee",    
              category: "Leisure",
              pic_path: "leisure/coffee.jpg",
              has_price: true,
              has_place: true,
              has_score: true,
              has_comment:true).save! 
Activity.create(name: "Bar",
              past_participle: "been to a bar",   
              category: "Leisure",
              pic_path: "leisure/bar.jpg",
              has_price: true,
              has_place: true,
              has_score: true,
              has_comment:true).save! 
Activity.create(name: "Nightclub",
              past_participle: "been to a nightclub",
              category: "Leisure",
              pic_path: "leisure/nightclub.jpg",
              has_price: true,
              has_place: true,
              has_score: true,
              has_comment:true).save!                
Activity.create(name: "Cinema",
              past_participle: "been to the cinema",
              category: "Leisure",
              pic_path: "leisure/cinema.jpg",
              has_price: true,
              has_place: true,
              has_score: true,
              has_comment:true).save! 
Activity.create(name: "Concert",
              past_participle: "been a concert",
              category: "Leisure",
              pic_path: "leisure/concert.jpg",
              has_price: true,
              has_place: true,
              has_score: true,
              has_comment:true).save!             
Activity.create(name: "Theatre",
              past_participle: "been a theatre",
              category: "Leisure",
              pic_path: "leisure/theatre.jpg",
              has_price: true,
              has_place: true,
              has_score: true,
              has_comment:true).save!             
Activity.create(name: "Meet friends",
              past_participle: "been with friends",
              category: "Leisure",
              pic_path: "leisure/friends.jpg",
              has_place: true).save! 
Activity.create(name: "Movie",
              past_participle: "watched a movie",
              category: "Leisure",
              pic_path: "leisure/movie.jpg",
              has_score: true,
              has_comment:true).save! 
Activity.create(name: "Video Games",
              past_participle: "played video games",
              category: "Leisure",
              pic_path: "leisure/videogames.jpg",
              has_score: true,
              has_comment:true).save! 
Activity.create(name: "Board Games",
              past_participle: "played board games",
              category: "Leisure",
              pic_path: "leisure/boardgames.jpg",
              has_score: true,
              has_comment:true).save!           
Activity.create(name: "Play an instrument",
              past_participle: "played an instrument",
              category: "Leisure",
              pic_path: "leisure/instrument.jpg").save! 


Achievement.create(name: "Sleep10h",
              pic_path: "achievements/marmotte.jpg").save!
Achievement.create(name: "Sleep12h",
              pic_path: "achievements/ours.jpg").save!
Achievement.create(name: "Sleep14h",
              pic_path: "achievements/snorlax.jpg").save!              
Achievement.create(name: "Sleep_c_1D",
              pic_path: "achievements/marmotte.jpg").save!
Achievement.create(name: "Sleep_c_1W",
              pic_path: "achievements/ours.jpg").save!
Achievement.create(name: "Sleep_c_1M",
              pic_path: "achievements/snorlax.jpg").save!  
              
Activity.find_by_name("Sleep").references!(Achievement.find_by_name("Sleep10h"))
Activity.find_by_name("Sleep").references!(Achievement.find_by_name("Sleep12h"))
Activity.find_by_name("Sleep").references!(Achievement.find_by_name("Sleep14h"))
Activity.find_by_name("Sleep").references!(Achievement.find_by_name("Sleep_c_1D"))
Activity.find_by_name("Sleep").references!(Achievement.find_by_name("Sleep_c_1W"))
Activity.find_by_name("Sleep").references!(Achievement.find_by_name("Sleep_c_1M"))



