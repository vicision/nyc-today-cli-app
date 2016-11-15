
require 'pry'

class NycToday::Scraper

  # @@doc = Nokogiri::HTML(open("http://nyc-shows.brooklynvegan.com/events/today"))

  @@main_url = "http://nyc-shows.brooklynvegan.com"

  @@page = Nokogiri::HTML(open("http://nyc-shows.brooklynvegan.com/events/today"))


  # def self.set_values(event)
  #   event_hash = {}
  #   url_end = event.css("a").attribute("href").value
  #   event_hash[:name] = event.css(".ds-listing-event-title-text").text
  #   event_hash[:venue] = event.css(".ds-venue-name").text.gsub!(/\s+/, " ").strip
  #   event_hash[:time] = event.css(".dtstart").text.gsub!(/\s+/, " ").strip
  #   event_hash[:event_link] = @@main_url + url_end
  #   event_hash
  # end

  def self.scrape_events
    self.scrape_music
    self.scrape_comedy
  end

  def self.scrape_music
    @@page.css(".ds-event-category-music").each do |event|
      url_end = event.css("a").attribute("href").value
      event_hash = {}
      event_hash[:name] = event.css(".ds-listing-event-title-text").text
      event_hash[:venue] = event.css(".ds-venue-name").text.gsub!(/\s+/, " ").strip
      event_hash[:time] = event.css(".dtstart").text.gsub!(/\s+/, " ").strip
      event_hash[:event_link] = @@main_url + url_end
      event_hash[:event_type] = "music"
      NycToday::Event.new(event_hash)
    end
  end

  def self.scrape_comedy
    @@page.css(".ds-event-category-comedy").each do |event|
      url_end = event.css("a").attribute("href").value
      event_hash = {}
      event_hash[:name] = event.css(".ds-listing-event-title-text").text
      event_hash[:venue] = event.css(".ds-venue-name").text.gsub!(/\s+/, " ").strip
      event_hash[:time] = event.css(".dtstart").text.gsub!(/\s+/, " ").strip
      event_hash[:event_link] = @@main_url + url_end
      event_hash[:event_type] = "comedy"
      NycToday::Event.new(event_hash)
    end
        # price_or_age: event_doc.css("h2.ds-ticket-info").text
        # event_hash.reject{|k,v| v.nil?}
        # if event.at_css(".ds-event-category-music")
        #   event_hash.store(:event_type, "music")
        # elsif event.at_css(".ds-event-category-comedy")
        #   event_hash[:event_type] = "comedy"
        # end
    binding.pry
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
