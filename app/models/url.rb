require 'uri'

class Url < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
  validates :long_url, :presence => true, :format => URI::regexp(%w(http https))
  before_create :shorten, :counter

  def shorten
    self.short_url = SecureRandom.base64(6)
  end

  def counter
    self.click_count = 0
  end
end
