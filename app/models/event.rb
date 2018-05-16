require 'date'

class Event
  attr_reader :id, :date, :display_name, :uri

  def initialize(data)
    @id = data.fetch("id")
    @display_name = data.fetch("displayName")
    @date = Date.parse(data.fetch("start").fetch("date"))
    @performances_hash = data.fetch("performance")
    @venue = data.fetch("venue")
    @type = data.fetch("type")
    @uri = data.fetch("uri")
  end

  def performances
    performances ||= @performances_hash.map { |performance| Performance.new(performance) }
  end

  def ==(other)
    other.class == self.class &&
    other.id == self.id
  end
  alias :eql? :==

  def hash
    "#{id}".hash
  end

  def artists
    @performances.map { |p| p["artist"]["displayName"] }.join(", ")
  end

  def title
    return display_name if is_festival?

    "#{artists} at #{venue_name}"
  end

  def venue_name
    @venue.fetch("displayName")
  end

  def headline_performances
    @headline_performances ||= performances.select { |performance| performance.is_headline? }
  end

  def is_festival?
    @type == "Festival"
  end

  def headliner_image
    return unless headline_performances.any?
    "//images.staging.songkick.net/images/media/profile_images/artists/#{headline_performances.first["artist"]["id"]}/huge_avatar"
  end
end
