
require 'pry'

class NycToday::Scraper

  # @@doc = Nokogiri::HTML(open("http://nyc-shows.brooklynvegan.com/events/today"))

  @@main_url = "http://nyc-shows.brooklynvegan.com"

  @@page = Nokogiri::HTML(open("http://nyc-shows.brooklynvegan.com/events/today"))




  def self.scrape_events
    @@page.css(".ds-event-category-music").each do |event|
      url_end = event.css("a").attribute("href").value
      # event_doc = Nokogiri::HTML(open(event_url))
      # event_hash = {}
      NycToday::Event.new({
        name: event.css(".ds-listing-event-title-text").text,
        venue: event.css(".ds-venue-name").text.gsub!(/\s+/, " ").strip,
        time: event.css(".dtstart").text.gsub!(/\s+/, " ").strip,
        event_link: @@main_url + url_end,
        event_type: if event.at_css(".ds-event-category-music")
          "music"
        elsif event.at_css("ds-event-category-comedy")
          "comedy"
        end

        # price_or_age: event_doc.css("h2.ds-ticket-info").text
        })
        # event_hash.reject{|k,v| v.nil?}
        # if event.at_css(".ds-event-category-music")
        #   event_hash.store(:event_type, "music")
        # elsif event.at_css(".ds-event-category-comedy")
        #   event_hash[:event_type] = "comedy"
        # end

    end
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
