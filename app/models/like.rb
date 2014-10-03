class Like < ActiveRecord::Base
  belongs_to :user_id
  belongs_to :bookmark_id
end
