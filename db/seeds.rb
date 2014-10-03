require 'faker'

5.times do
  user = User.new(
      name: Faker::Name.name,
      email:Faker::Internet.email,
      password: Faker::Lorem.characters(10)
  )
  # user.skip_confirmation! - since confirmation emails are turned off
  user.save!
end

me = User.new(
    name:     'Me',
    email:    'dwilbank@gmail.com',
    password: '1aberath'
)
# me.skip_confirmation! - since confirmation emails are turned off
me.save!

users = User.all

topic_num = 1
15.times do
  Topic.create(
      name:       "Topic " + topic_num.to_s + " " + Faker::Lorem.word,
  )
  topic_num += 1
end
topics = Topic.all

bookmark_num = 1
1000.times do
  bookmark = Bookmark.create!(
      user: users.sample,
      topic: topics.sample,
      url: "Bookmark " + bookmark_num.to_s + " " + Faker::Internet.url,
  )

  bookmark.update_attributes!(created_at: rand(10.minutes .. 1.year).ago)
  bookmark_num += 1
end
bookmarks = Bookmark.all

2000.times do
  Like.create!(
      user_id: users.sample.id,
      bookmark_id: bookmarks.sample.id
  )
end

puts 'Seed finished'
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Bookmark.count} bookmarks created"
puts "#{Like.count} likes created"

