URL = "http://webthumb.bluga.net/easythumb.php?user=77017&url=www.consumerreports.com&hash=578f71e9c7f50bf11a53218c6739affa&size=medium&cache=30"

require 'nokogiri' # gem install nokogiri
require 'open-uri' # already part of your ruby install

image = Nokogiri::HTML(open(URL))
puts image.at_css('.decoded')
