class Recommendation
  def initialize(event_attendance, because_you_like_artists)
    @event_attendance = event_attendance
    @because_you_like_artists = because_you_like_artists
  end

  def event_name
    @event_attendance.event.display_name
  end

  def event_uri
    @event_attendance.event.uri
  end

  def seed_artists
    artists = @because_you_like_artists.map { |artist| artist.name }
    to_sentence(artists)
  end

  def users_going
    users_going = @event_attendance.users_going
    "#{to_sentence(users_going)} #{users_going.length == 1 ? 'is' : 'are'} going"
  end

  private

  def to_sentence(arr)
    arr.to_sentence(last_word_connector: ' and ')
  end
end
