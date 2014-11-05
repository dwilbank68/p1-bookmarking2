class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :bookmark

  #validates_uniqueness_of :user_id, scope: :bookmark_id

end
