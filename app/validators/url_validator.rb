require 'net/http'
require 'net/smtp'

# class UrlValidator < ActiveModel::Validator
#   def validate(record)
#     res = Net::HTTP.get_response(URI.parse(record.url))
#     # unless ["OK", "Object moved", "Moved Permanently", "Found"].include? res.response.msg
#     unless ["200", "301", "302"].include? res.code
#       # record.errors[:url] << "#{record.url} invalid - #{res.response.msg}"
#       record.errors[:url] << "#{record.url} invalid - #{res.code}"
#     end
#   end
# end

# require 'net/http';
# require 'net/smtp';
# res = Net::HTTP.get_response(URI.parse("http://www.lifehacker.com"));
# res.response.msg;
###### delete everything below. it is just for question purposes

class UrlValidator < ActiveModel::Validator
  def validate(record)

    begin

      res = Net::HTTP.get_response(URI.parse(record.url))
      unless ["200", "301", "302"].include? res.code
        record.errors[:url] << "#{record.url} invalid - #{res.code}"
      end

    rescue Exception
      record.errors[:url] << "#{record.url} invalid - Exception"
    end

  end
end