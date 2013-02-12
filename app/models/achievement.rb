class Achievement < ActiveRecord::Base
  attr_accessible :name,:pic_path

  has_and_belongs_to_many  :activities
  has_and_belongs_to_many  :users
  def check(user)
    if(user.has_achievement(self.id))
    return false
    else
      case self.name
      when "Sleep10h"
        if(max_sleep_time(user)>=36000)
        return true
        end
        return false

      when "Sleep12h"
        if(max_sleep_time(user)>=43200)
        return true
        end
        return false

      when "Sleep14h"
        if(max_sleep_time(user)>=50400)
        return true
        end
        return false

      when "Sleep_c_1D"
        if(total_sleep_time(user)>=86400)
        return true
        end
        return false

      when "Sleep_c_1W"
        if(total_sleep_time(user)>=604800)
        return true
        end
        return false

      when "Sleep_c_1M"
        if(total_sleep_time(user)>=2419200)
        return true
        end
        return false
      end
    end
    return false
  end

  def max_sleep_time(user)
    return user.user_doing(Action.find_by_name("Sleep").id).max_by(&:duration).duration
  end

  def total_sleep_time(user)
    total=0
    user.user_doing(Action.find_by_name("Sleep").id).each do |action|
      total+=action.duration
    end
    return total
  end

end
