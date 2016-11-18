
require 'pry'

class NycToday::Scraper

  # @@doc = Nokogiri::HTML(open("http://nyc-shows.brooklynvegan.com/events/today"))

  @@main_url = "http://nyc-shows.brooklynvegan.com"
  @@pages = []

  def self.get_pages
    num = 0
    page_url = @@main_url + "/events/today?page=#{num}"
    while num < 11
      @@pages << Nokogiri::HTML(open(page_url))
      num += 1
    end
  end




  def self.scrape_events
    get_pages
    @@pages.each do |page|
      page.css(".event-card").each do |event|
        url_end = event.css("a").attribute("href").value
        event_hash = {}
        event_hash[:name] = event.css(".ds-listing-event-title-text").text.strip
        event_hash[:venue] = event.css(".ds-venue-name").text.gsub!(/\s+/, " ").strip
        event_hash[:time] = event.css(".dtstart").text.gsub!(/\s+/, " ").strip
        event_hash[:event_link] = @@main_url + url_end
        NycToday::Event.new(event_hash)
      end
    end
  end
end
