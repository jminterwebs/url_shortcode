class ShortUrl < ApplicationRecord
  require 'open-uri'

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze


  
  validate :validate_full_url
  validates :full_url, presence: true 
  after_create :shorten_code

  def shorten_code
    num = self.id
    return CHARACTERS[0] if num == 0
    result = ""
      while num > 0
        r = num % CHARACTERS.count
        result.prepend(CHARACTERS[r])
        num = (num / CHARACTERS.count).floor
      end
    
    self.update(short_code: result)
    self.update_title!
    result
  end

  def update_title!
    title = UpdateTitleJob.perform_now(self.id)
    self.title = title
    self
  end

  def public_attributes
    self.attributes.slice('id', 'full_url', 'title', 'click_count', 'short_code')   
  end

  private

  def validate_full_url
    #validate any urls with an "OK" response and 200 status
    begin
      raise errors.add(:errors, "Full url is not a valid url") unless open(full_url).status == ["200","OK"]
    rescue
      errors.add(:full_url, "is not a valid url")
    end
  end

  

end
