require 'net/http'
require 'net/smtp'

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
