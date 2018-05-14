class User

  def initialize(username, friends)
    @username = username
    @friends = friends
  end

  private

  def artist_trackings
    @artist_trackings ||= begin
      trackings = Yaypi.artist_trackings_for_user(@username)
      if trackings.present?
        trackings.map { |artist_hash| Artist.new(artist_hash) }
      end
    end
  end

  def friends_attendances
    @friends_attendances ||= begin
      attendances = @friends.collect do |friend_username|
        Yaypi.im_goings_for_user(friend_username)
      end

      attendances.flatten.uniq.map do |event_hash|
        Event.new(event_hash)
      end
    end
  end
end
