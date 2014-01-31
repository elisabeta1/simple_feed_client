class SimpleFeedClient
  class Item

    attr_reader :feed, :user
    attr_accessor :type, :image_url, :link, :text, :id, :created_at

    def initialize(args)
      @type = args[:type]
      @image_url = args[:image_url]
      @link = args[:link]
      @id = args[:id]
      @text = args[:text]
      @created_at = Time.parse args[:created_at]
      @feed = SimpleFeedClient::Feed.new(args[:feed]) if !args[:feed].nil?
      @user = SimpleFeedClient::User.new(args[:user]) if !args[:user].nil?
    end
  end
end