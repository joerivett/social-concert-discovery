class User

  def initialize(username, friends)
    @username = username
    @friends = friends
  end

  def recommendations
    @recommendations ||= begin
      friends_attendances.collect do |event_attendance|
        event = event_attendance.event
        next if event.headline_performances.empty?

        headliner = event.headline_performances.first.artist
        # If the user already tracks the headline artist, they will know about this event already
        unless tracks_artist? headliner
          # User doesn't track this event headliner, so let's see if there's any common
          # ground with this user's trackings and the headliner's similar artists
          intersection = artist_trackings & headliner.similar_artists
          unless intersection.empty?
            # This user tracks at least one of the artists similar to this event's headliner
            Recommendation.new(event_attendance, intersection)
          end
        end
      end.compact
    end
  end

  private

  def artist_trackings
    @artist_trackings ||= begin
      trackings = Yaypi.artist_trackings_for_user(@username)

      trackings.map { |artist_hash| Artist.new(artist_hash) }
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

  def tracks_artist?(artist)
    artist_trackings.any? { |tracked_artist| tracked_artist.id == artist.id }
  end
end
