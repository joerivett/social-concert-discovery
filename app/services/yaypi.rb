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

  private

  API_KEY='FUJrrB2gcyUsDqRc'
  API_ENDPOINT = 'https://api.songkick.com/api/3.0'

  def self.get(url)
    uri = URI(API_ENDPOINT << url)
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

end
