class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page],per_page: 5)
      @feed_action_items = current_user.action_feed.paginate(page: params[:page],per_page: 5)
      @global_feed_items=current_user.feed+current_user.action_feed
      @global_feed_items.sort {|obj1, obj2| obj2.date_sort <=> obj1.date_sort}
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
