class Artist
  def initialize(artist_hash)
    @artist_hash = artist_hash
  end

  def id
    @artist_hash['id']
  end

  def name
    @artist_hash['displayName']
  end
end
