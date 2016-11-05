
require 'pry'

class NycToday::Scraper

  @@doc = Nokogiri::HTML(open("http://nyc-shows.brooklynvegan.com/events/today"))


  def self.scrape_events
    # event_doc = self.scrape_event
    @@doc.css(".ds-listing").each do |event|
      url_front = "http://nyc-shows.brooklynvegan.com"
      url_back = event.css("a").attribute("href").value
      event_url = url_front + url_back
      event_doc = Nokogiri::HTML(open(event_url))

      event_hash = NycToday::Event.new({
        name: event.css(".ds-listing-event-title-text").text,
        venue: event.css(".ds-venue-name").text.gsub(/\s+/, " ").strip,
        time: event.css(".dtstart").text.gsub(/\s+/, " ").strip,
        price_or_age: event_doc.css("h2.ds-ticket-info").text
        })
    end
  end

  # def self.scrape_event
  #   event_url = ""
  #   @@doc.css(".ds-listing").each do |event|
  #     url_front = "http://nyc-shows.brooklynvegan.com"
  #     url_back = event.css("a").attribute("href").value
  #     event_url = url_front + url_back
  #   end

  # end

end
