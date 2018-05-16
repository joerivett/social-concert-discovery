class Recommendation
  def initialize(event_attendance, because_you_like_artists)
    @event_attendance = event_attendance
    @because_you_like_artists = because_you_like_artists
  end

  def to_str
    artists = @because_you_like_artists.map { |artist| artist.name }
    users_going = @event_attendance.users_going
    str = "We recommend #{@event_attendance.event.display_name} "
    str << "because you like #{to_sentence(artists)}. "
    str << "#{to_sentence(users_going)} "
    str << "#{users_going.length == 1 ? 'is' : 'are'} "
    str << "going."
  end

  private

  def to_sentence(arr)
    arr.to_sentence(last_word_connector: ' and ')
  end
end
