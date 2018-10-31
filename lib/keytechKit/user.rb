require 'keytechKit/targetlink'
module KeytechKit
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
      userData = response['MembersList'][0]

      self.isActive = userData['IsActive']
      self.isAdmin = userData['IsAdmin']
      self.isSuperuser = userData['IsSuperuser']
      self.name = userData['KeyName']
      self.languageID = userData['LanguageID']
      self.longName = userData['Longname']
      self.mail = userData['MailAddress']
    end
  end
end
