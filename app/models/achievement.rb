class Achievement < ActiveRecord::Base
  attr_accessible :name,:pic_path

  has_and_belongs_to_many  :actions
  has_and_belongs_to_many  :users
  def check(user)
    if(user.has_achievement(self.id))
    return false
    else
      case self.name
      when "Sleep10h"
        user.user_doing(Action.find_by_name("Sleep").id).each do |action|
          if(action.duration>=36000)
          return true
          end
        end
        return false

      when "Sleep12h"
        user.user_doing(Action.find_by_name("Sleep").id).each do |action|
          if(action.duration>=43200)
          return true
          end
        end
        return false

      when "Sleep14h"
        user.user_doing(Action.find_by_name("Sleep").id).each do |action|
          if(action.duration>=50400)
          return true
          end
        end
        return false

      when "Sleep_c_1D"
        return false

      when "Sleep_c_1W"
        return false

      when "Sleep_c_1M"
        return false
      end
    end
    return false
  end
end
