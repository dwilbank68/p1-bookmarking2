require 'net/http'
require 'net/smtp'

class UrlValidator < ActiveModel::Validator
  def validate(record)
    res = Net::HTTP.get_response(URI.parse(record.url))
    unless res.response.msg == "OK"
      record.errors[:url] << 'url is invalid'
    end
  end
end