require 'keytechKit/targetlink'
module KeytechKit
  ##
  # The user Object
  # This represents a keytech user.
  class User
    include HTTParty
    default_timeout 10

    attr_accessor :response

    attr_accessor :isActive
    attr_accessor :isAdmin
    attr_accessor :isSuperuser
    attr_accessor :name
    attr_accessor :languageID
    attr_accessor :longName
    attr_accessor :mail

    def initialize(base_url, username, password)
      self.class.base_uri(base_url)
      @auth = { username: username, password: password }
    end

    # Returns a updated user object
    # username = key of user
    def load(username)
      options = {}
      options[:basic_auth] = @auth
      response = self.class.get("/user/#{username}", options)
      if response.success?
        self.response = response
        parse_response
        self
      else
        raise response.response
      end
    end

    def queries(options = {})
      load_target_links('queries', options)
    end

    def favorites
      load_target_links('favorites')
    end

    private

    def load_target_links(linkType, options = {})
      parameter = { query: options }
      parameter[:basic_auth] = @auth
      response = self.class.get("/user/#{name}/#{linkType}", parameter)
      if response.success?
        targetLinks_response = response['TargetLinks']
        targetLinks = []
        targetLinks_response.each do |link_response|
          targetLinks.push Targetlink.new(link_response)
        end
        targetLinks
      else
        raise response.response
      end
    end

    def parse_response
      # Only one user should be returns every time
      user_data = response['MembersList'][0]

      self.isActive = user_data['IsActive']
      self.isAdmin = user_data['IsAdmin']
      self.isSuperuser = user_data['IsSuperuser']
      self.name = user_data['KeyName']
      self.languageID = user_data['LanguageID']
      self.longName = user_data['Longname']
      self.mail = user_data['MailAddress']
    end
  end
end
