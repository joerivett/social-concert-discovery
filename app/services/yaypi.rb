require "json"
require 'net/http'
require 'net/https'

class Yaypi

  def self.im_goings_for_user(username)
    return unless username.present?

    response = get("/users/#{username}/events.json?attendance=im_going")

    json = JSON.parse(response)
    json['resultsPage']['results']['event'] || [] rescue []
  end

  def self.artist_trackings_for_user(username)
    return unless username.present?

    artists = []
    page = 1
    # Results are paginated. Loop until we have all tracked artists
    loop do
      response = get("/users/#{username}/artists/tracked.json?page=#{page}")

      json = JSON.parse(response)
      artists_json = json['resultsPage']['results']['artist'] || [] rescue []
      break if artists_json.empty?

      total_artists = json['resultsPage']['totalEntries'].to_i

      artists += artists_json

      break unless get_next_page?(artists, total_artists)
      page += 1
    end

    artists
  end

  private

  API_KEY='FUJrrB2gcyUsDqRc'.freeze
  API_ENDPOINT = 'https://api.songkick.com/api/3.0'.freeze

  def self.get(url)
    uri = URI(API_ENDPOINT + url)
    uri.query = uri.query.nil? ? '' : "#{uri.query}&"
    # Append API key to url
    uri.query << "apikey=#{API_KEY}"

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    req =  Net::HTTP::Get.new(uri)

    # Fetch Request
    res = http.request(req)
    res.body
  end

  def self.get_next_page?(artists, total_artists)
    artists.length < total_artists
  end

end
