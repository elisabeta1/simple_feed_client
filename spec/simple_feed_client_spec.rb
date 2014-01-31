require './lib/simple_feed_client'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = './spec/fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
end

describe SimpleFeedClient do 
  it "Integration: returns the user feed" do
    VCR.use_cassette('feeds_for_user') do 
      client = SimpleFeedClient.new("feed", "simple")
      feeds = client.get_feed_by_user("feed")    
      expect(feeds.size).to eq(2)

      item = feeds.first    
      expect(item.type).to      eq "ImageItem"
      expect(item.image_url).to eq "http://upload.wikimedia.org/wikipedia/commons/2/22/Turkish_Van_Cat.jpg"
      expect(item.text).to      eq "Beautiful white cat!!"
      expect(item.id).to        eq 44
      expect(item.created_at).to eq Time.parse("2014-01-30T16:51:36Z")
      expect(item.link).to      eq "http://localhost:3000/api/feeds/feed/items/44.json"

      feed = item.feed
      expect(feed.link).to eq "http://localhost:3000/api/feeds/feed.json"
      expect(feed.name).to eq "feed"

      user = item.user
      expect(user.username).to eq "feed"
      expect(user.email).to    eq "elisabeta.kadilli@surfdome.com"
      expect(user.gravatar).to eq "http://www.gravatar.com/avatar/04f4fb70f46263999a47b55d0eab32d2?s=40"
    end
  end

  describe SimpleFeedClient::Item do
    it "initializes item class with values" do
      item = SimpleFeedClient::Item.new(type: "test", image_url: "http://google.com/image.jpg", id: 12, text: "testing text", created_at: "2013-01-30T16:51:36Z", link: "http://surfdome.com")

      expect(item.type).to      eq "test"
      expect(item.image_url).to eq "http://google.com/image.jpg"
      expect(item.text).to      eq "testing text"
      expect(item.id).to        eq 12
      expect(item.created_at).to eq Time.parse("2013-01-30T16:51:36Z")
      expect(item.link).to      eq "http://surfdome.com"
    end
  end

  describe SimpleFeedClient::Feed do
    it "initializes new feed class with values" do
      feed = SimpleFeedClient::Feed.new(link: "http://localhost:3000/api/feeds/feed.json", name: "feed")

      expect(feed.link).to eq "http://localhost:3000/api/feeds/feed.json"
      expect(feed.name).to eq "feed"
    end
  end

  describe SimpleFeedClient::User do
    it "initializes new user class with values" do
      user = SimpleFeedClient::User.new(username: "feed", email: "elisabeta.kadilli@surfdome.com", gravatar: "http://www.gravatar.com/avatar/04f4fb70f46263999a47b55d0eab32d2?s=40")

      expect(user.username).to eq "feed"
      expect(user.email).to    eq "elisabeta.kadilli@surfdome.com"
      expect(user.gravatar).to eq "http://www.gravatar.com/avatar/04f4fb70f46263999a47b55d0eab32d2?s=40"
    end
  end


end

 