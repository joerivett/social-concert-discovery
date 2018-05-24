require "json"
require 'net/http'
require 'net/https'

class SongkickAPI

  def self.im_goings_for_user(username)
    return unless username.present?

    response = get("/users/#{username}/events.json", "attendance=im_going")

    json = JSON.parse(response)
    json['resultsPage']['results']['event'] || [] rescue []
  end

  def self.artist_trackings_for_user(username)
    return unless username.present?

    artists = []
    page = 1
    # Results are paginated. Loop until we have all tracked artists
    loop do
      response = get("/users/#{username}/artists/tracked.json", "page=#{page}")

      json = JSON.parse(response)
      artists_json = json['resultsPage']['results']['artist'] || [] rescue []

      break if artists_json.empty?

      artists += artists_json
      total_artists = json['resultsPage']['totalEntries'].to_i

      break if artists.length >= total_artists

      page += 1
    end

    artists
  end

  def self.similar_artists(artist_id)
    return unless artist_id.present?

    response = get("/artists/#{artist_id}/similar_artists.json")

    json = JSON.parse(response)
    json['resultsPage']['results']['artist'] || [] rescue []
  end

  private

  API_ENDPOINT = 'https://api.songkick.com/api/3.0'.freeze

  def self.get(path, params = '')
    params += "&" if params.length > 0
    params += "apikey=hackday"

    path += "?" + params

    uri = URI(API_ENDPOINT + path)

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    req =  Net::HTTP::Get.new(uri)

    # Fetch Request
    res = http.request(req)
    res.body
  end
end
