class SimpleFeedClient
  class User

    attr_accessor :username, :email, :gravatar

    def initialize (attributes)
      @username = attributes[:username]
      @email = attributes[:email]
      @gravatar = attributes[:gravatar]
    end
    
  end
end