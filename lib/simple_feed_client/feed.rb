class SimpleFeedClient
  class Feed

    attr_accessor :link, :name

    def initialize(attributes)
      @link = attributes[:link]
      @name = attributes[:name]
    end

  end
end