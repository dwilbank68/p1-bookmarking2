class Topic < ActiveRecord::Base
  belongs_to  :user
  has_many    :bookmarks

  validates :name, { :uniqueness => true }

  before_destroy :check_for_bookmarks

  default_scope {order('name')}

  def liked_bookmarks(cur_usr)
    return nil unless cur_usr
    liked_bookmark_ids = cur_usr.likes.pluck(:bookmark_id)
    bookmarks.where(id:liked_bookmark_ids).order('created_at DESC')
  end

  def check_for_bookmarks
    if bookmarks.any?
      errors[:base] << "cannot delete topic that still contains posts"
      return false
    end
  end

  def color_topic # distributes color-0 thru color-4 equally through all topics
    puts self.id
    "color-#{self.id % 5}"
  end

end

