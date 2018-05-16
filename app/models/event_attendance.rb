# This class stores an event and a list of users who are attending it
class EventAttendance

  attr_reader :event, :users_going

  def initialize
    @users_going = []
  end

  def add_attending_user(username)
    @users_going << username
  end

  def event=(event_hash)
    @event = Event.new(event_hash) unless @event.present?
  end
end
