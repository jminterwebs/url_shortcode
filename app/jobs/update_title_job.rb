class UpdateTitleJob < ApplicationJob
  queue_as :default

  def perform(short_url_id)
    short_url = ShortUrl.find(short_url_id)
    doc = Nokogiri::HTML(open("#{short_url.full_url}"))
    title = doc.css("title").text
    short_url.update_attribute(:title, title)
    title
  end
end
