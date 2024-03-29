class Artist
  def initialize(artist_hash)
    @artist_hash = artist_hash
  end

  def ==(other)
    other.class == self.class &&
    other.id == self.id
  end
  alias :eql? :==

  def id
    @artist_hash['id']
  end

  def hash
    self.id.hash
  end

  def name
    @artist_hash['displayName']
  end

  def similar_artists
    @similar_artists ||= begin
      artists = SongkickAPI.similar_artists(id)

      artists.map do |event_hash|
        Artist.new(event_hash)
      end
    end
  end
end
