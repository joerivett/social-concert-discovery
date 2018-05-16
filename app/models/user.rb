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
      attendances = Hash.new { |hash, event_id| hash[event_id] = EventAttendance.new }
      @friends.each do |friend_username|
        Yaypi.im_goings_for_user(friend_username).each do |attendance_hash|
          event_id = attendance_hash.fetch('id')
          attendances[event_id].event = attendance_hash
          attendances[event_id].add_attending_user(friend_username)
        end
      end
      attendances.values
    end
  end

  def friends_attendances_headline_artists
    @friends_attendances_headliners ||= begin
      friends_attendances.collect { |friends_attendance| friends_attendance.performances.each { |perf| p perf.artist.name}  }
    end
  end
end
