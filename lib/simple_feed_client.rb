require 'rest-client'
require 'json'
require 'simple_feed_client/item'
require 'simple_feed_client/feed'
require 'simple_feed_client/user'

class SimpleFeedClient
  attr_accessor :username, :password

  def initialize(username, password)
    self.username = username
    self.password = password
  end

  def get_feed_by_user(user)
    response = RestClient.get "http://#{username}:#{password}@localhost:3000/api/feeds/#{user}/items.json"
    json_response = JSON.parse response, symbolize_names: true
    convert_to_items json_response
  end

  private

  def convert_to_items(json_items)
    json_items.map do |item|
      SimpleFeedClient::Item.new item
    end
  end
  
end