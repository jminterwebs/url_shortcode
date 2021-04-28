class ShortUrl < ApplicationRecord

  CHARACTERS = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  validate :validate_full_url

  def short_code
  end

  def update_title!
  end

  private

  def validate_full_url
    #validate any urls with an "OK" response and 200 status

    begin
      raise errors.add(:errors, "Full url is not a valid url") unless open(full_url).status == ["200","OK"]
    rescue
      errors.add(:errors, "Full url is not a valid url")
    end


  end

end
