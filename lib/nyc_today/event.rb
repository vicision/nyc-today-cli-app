class NycToday::Event
  attr_accessor :name, :venue, :time, :time_stamp, :event_link

  @@all = []

  def initialize(hash)
    hash.each do |key, value|
      self.send("#{key}=", value)
    end
    @@all.push(self)
    # @@all.uniq! do |e|
    #   {e[:name], e[:venue], e[:time]}
    # end
  end

  def self.all
    # @@all.uniq! {|e| e.event_link}
    @@all.sort_by!{|e|e.time_stamp}.each_slice(10).to_a
  end

  def reset
    @all.clear!
  end


end
