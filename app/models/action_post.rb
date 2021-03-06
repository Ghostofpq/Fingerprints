class ActionPost < ActiveRecord::Base
  include ActionView::Helpers::DateHelper
  attr_accessible :start_date, :end_date, :comment, :place, :score, :price,:activity_id,:public
  belongs_to :user

  validates :user_id, presence: true
  validates :activity_id, presence: true

  default_scope order: 'action_posts.start_date DESC'
  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("(user_id IN (#{followed_user_ids}) AND public = :public) OR user_id = :user_id",
          user_id: user.id, public: true)
  end

  def self.from_user_only(user)
    where("user_id = :user_id", user_id: user.id)
  end

  def self.from_user_only_doing(user,activity_id)
    where("user_id = :user_id and activity_id=:activity_id", user_id: user.id,activity_id: activity_id)
  end

  def self.public_ones(user)
    where("public = :public AND user_id = :user_id",user_id: user.id, public: true)
  end

  def get_price
    if self.price==nil
    return 0.to_f
    end
    return self.price.to_f
  end

  def duration
    return (self.end_date.to_time-self.start_date.to_time)
  end

  def duration_human
    return distance_of_time_in_words(self.start_date.to_time,self.end_date.to_time)
  end

  def score_img
    if self.score==0
      return "F.jpg"
    elsif self.score==1
      return "E_moins.jpg"
    elsif self.score==2
      return "E.jpg"
    elsif self.score==3
      return "D_moins.jpg"
    elsif self.score==4
      return "D.jpg"
    elsif self.score==5
      return "C.jpg"
    elsif self.score==6
      return "C.jpg"
    elsif self.score==7
      return "B.jpg"
    elsif self.score==8
      return "B_plus.jpg"
    elsif self.score==9
      return "A.jpg"
    elsif self.score==10
      return "A_plus.jpg"
    end
  end

  def is_on_one_day
    return (local_start_date.to_date==local_end_date.to_date)
  end

  def local_start_date
    return start_date.in_time_zone(Time.zone)
  end

  def local_end_date
    return end_date.in_time_zone(Time.zone)
  end

  def duration_in_quarters(date,third)

    if(third==1)
      if(local_start_date<=date.beginning_of_day().in_time_zone(Time.zone))
        t_start=date.beginning_of_day().in_time_zone(Time.zone)
      else
        t_start=local_start_date.to_time
      end

      if(date.beginning_of_day().in_time_zone(Time.zone)+8.hours<=local_end_date.to_time)
        t_end=date.beginning_of_day().in_time_zone(Time.zone)+8.hours
      else
        t_end=local_end_date.to_time
      end

    elsif (third==2)
      if(local_start_date<date.beginning_of_day().in_time_zone(Time.zone)+8.hours)
        t_start=date.beginning_of_day().in_time_zone(Time.zone)+8.hours
      else
        t_start=local_start_date.to_time
      end

      if(date.beginning_of_day().in_time_zone(Time.zone)+16.hours<=local_end_date.to_time)
        t_end=date.beginning_of_day().in_time_zone(Time.zone)+16.hours
      else
        t_end=local_end_date.to_time
      end

    elsif (third==3)
      if(local_start_date<date.beginning_of_day().in_time_zone(Time.zone)+16.hours)
        t_start=date.beginning_of_day().in_time_zone(Time.zone)+16.hours
      else
        t_start=local_start_date.to_time
      end

      if(date.beginning_of_day().in_time_zone(Time.zone)+24.hours<=local_end_date.to_time)
        t_end=date.beginning_of_day().in_time_zone(Time.zone)+24.hours
      else
        t_end=local_end_date.to_time
      end
    end
    diff = (t_end-t_start)

    ret=(diff/(900)).round.to_i

    if(ret==0)
    return 1
    else
    return ret
    end
  end

  def activity
    Activity.find(activity_id)
  end

  def date_sort
    self.start_date
  end

  def is_in_first_third_of_the_day(date)
    if(self.local_start_date<=(date+8.hours) || self.local_end_date<=(date+8.hours))
    return true
    end
    return false
  end

  def is_in_second_third_of_the_day(date)
    if(
    ((date+8.hours<self.local_start_date) && (self.local_start_date<=date+16.hours)) ||
    ((date+8.hours<self.local_end_date-8.minutes) && (self.local_end_date<=date+16.hours))
    )
    return true
    end
    return false
  end

  def is_in_third_third_of_the_day(date)
    if(
    ((date+16.hours<self.local_start_date) && (self.local_start_date<=date+24.hours)) ||
    ((date+16.hours<self.local_end_date-8.minutes) && (self.local_end_date<=date+24.hours))
    )
    return true
    end
    return false
  end
end
