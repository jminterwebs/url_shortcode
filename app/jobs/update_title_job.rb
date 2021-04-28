class UpdateTitleJob < ApplicationJob
  queue_as :default

  def perform(short_url)
    doc = Nokogiri::HTML(open("#{short_url.full_url}"))
    title = doc.css("title").text
    short_url.update(title: title)
  end
end
