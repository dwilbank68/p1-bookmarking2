require 'faker'
require 'embedly'
require 'json'
require 'net/http'
require 'net/smtp'

url_list = ["http://www.cifs.dk",
            "http://www.corante.com",
            "http://www.davidreport.com",
            "http://www.davinciinstitute.com",
            "http://www.doorsofperception.com",
            "http://www.european-futurists.org",
            "http://www.futurefeeder.com",
            "http://www.futurefoundation.net",
            "http://www.futuresfoundation.org.au",
            "http://futurewire.blogspot.com",
            "http://www.iftf.org",
            "http://www.plausiblefutures.com",
            "http://www.psfk.com",
            "http://www.rahs.org.sg",
            "http://www.shapingtomorrow.com",
            "http://www.socialtechnologies.com",
            "http://www.springwise.com",
            "http://www.trendbuero.de",
            "http://www.trendcentral.com",
            "http://www.trendwatching.com",
            "http://www.tse.fi",
            "http://www.wfs.org",
            "http://www.williamsinference.com",
            "http://www.futureshouse.eu",
            "http://www.futureexploration.net",
            "http://www.futureshouse.com",
            "http://www.outsights.co.uk",
            "http://www.imaginatik.com",
            "http://www.innovationwatch.com",
            "http://www.innovic.com.au",
            "http://www.whatifinnovation.com",
            "http://www.innotown.com",
            "http://www.intelligencesquared.com",
            "http://www.instituteofideas.com",
            "http://www.forum-21.com",
            "http://www.parc.com",
            "http://www.rsa.org.uk",
            "http://www.sydneytalks.com.au",
            "http://www.ted.com",
            "http://www.austhink.org/",
            "http://www.extendlimits.nl",
            "http://www.eurasiagroup.net",
            "http://www.pfcenergy.com",
            "http://www.squidoo.com",
            "http://eurasiagroup.net",
            "http://www.chathamhouse.org",
            "http://www.mckinsey.com/insights/mgi.aspx",
            "http://www.aldaily.com/",
            "http://www.theatlantic.com",
            "http://www.bbc.co.uk",
            "http://www.economist.com",
            "http://ads.economist.com/intelligent-life/introduction/",
            "http://www.fastcompany.com",
            "http://www.ft.com",
            "http://www.guardian.co.uk",
            "http://www.harpers.org",
            "http://www.hbr.org",
            "http://www.homepagedaily.com",
            "http://mckinseyquarterly.com",
            "http://money.cnn.com/magazines/business2/",
            "http://www.newscientist.com",
            "http://www.newyorker.com",
            "http://www.nytimes.com",
            "http://www.observer.co.uk",
            "http://www.prospectmagazine.co.uk",
            "http://radar.oreilly.com",
            "http://www.redherring.com",
            "http://www.salon.com",
            "http://www.sciencedaily.com",
            "http://www.slate.com",
            "http://www.spiked-online.com",
            "http://www.thenation.com",
            "http://www.strategy-business.com",
            "http://www.techreview.com",
            "http://www.washingtonpost.com",
            "http://www.wired.com",
            "http://www.aeonmagazine.com",
            "http://www.dgquarterly.com",
            "http://www.arcfinity.org"]

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

boss = User.new(
    name:     'Boss',
    email:    'dwilbank2@gmail.com',
    password: '1aberath2',
    role:     'admin'
)
# boss.skip_confirmation! - since confirmation emails are turned off
boss.save!

users = User.all

15.times do
  Topic.create(
      name: Faker::Lorem.word,
  )
end
color = topic.color_topic(topic.id)
topic.update_attributes(color:color)
topics = Topic.all

# bookmark_num = 1
# 100.times do
#   bookmark = Bookmark.create!(
#       user: users.sample,
#       topic: topics.sample,
#       url: "Bookmark " + bookmark_num.to_s + " " + Faker::Internet.url,
#   )
#
#   bookmark.update_attributes!(created_at: rand(10.minutes .. 1.year).ago)
#   bookmark_num += 1
# end
# bookmarks = Bookmark.all
url_list.each do |url|
  user = users.sample
  topic = topics.sample
  embedly_api = Embedly::API.new :key => '8837e2d5c8d14881a505d2fe96f40076', :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)'
  embedly_obj = embedly_api.extract :url => url
  embed = embedly_obj[0][:media][:html]

  base = "http://api.embed.ly/1/oembed?url=";
  safe_url = CGI.escape(url);
  res = Net::HTTP.get_response(URI.parse(base + safe_url));
  embedly_json = JSON.parse(res.body)
  thumbnail_url = embedly_json["thumbnail_url"];



  bookmark = user.bookmarks.build(:url => url,
                                  :topic => topic,
                                  :description => embedly_obj[0][:description],
                                  :title => embedly_obj[0][:title],
                                  :thumbnail => thumbnail_url,
                                  :embed => embed)
  bookmark.update_attributes!(created_at: rand(10.minutes .. 1.year).ago)
  bookmark.save
end
bookmarks = Bookmark.all



2000.times do
  Like.create(
      user_id: users.sample.id,
      bookmark_id: bookmarks.sample.id
  )
end

puts 'Seed finished'
puts "#{User.count} users created"
puts "#{Topic.count} topics created"
puts "#{Bookmark.count} bookmarks created"
puts "#{Like.count} likes created"

#http://api.embed.ly/1/oembed?key=:8837e2d5c8d14881a505d2fe96f40076&url=:http%3A//www.eurasiagroup.net&maxwidth=:300