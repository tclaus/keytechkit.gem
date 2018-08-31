require 'keytechKit/targetlink'
module KeytechKit
  class User
    include HTTParty
    attr_accessor :response

    attr_accessor :isActive
    attr_accessor :isAdmin
    attr_accessor :isSuperuser
    attr_accessor :name
    attr_accessor :languageID
    attr_accessor :longname
    attr_accessor :mail

    def initialize(base_url, username, password)
      self.class.base_uri(base_url)
      @auth = { username: username, password: password }
    end

    # Returns a updated user object
    # username = key of user
    def load_by_name(username)
      options = {}
      options.merge!(basic_auth: @auth)
      response = self.class.get("/user/#{username}", options)
      if response.success?
         self.response = response
         parse_response
         self
       else
         raise response.response
      end
    end

    def queries
      load_target_links("queries")
    end

    def favorites
      load_target_links("favorites")
    end

    private

    def load_target_links(linkType)
      options = {}
      options.merge!(basic_auth: @auth)
      response = self.class.get("/user/#{self.name}/#{linkType}", options)
      if response.success?
         targetLinks_response = response["TargetLinks"]
         targetLinks  = Array.new
         targetLinks_response.each do |favorite_response|
           targetLinks.push Targetlink.new(favorite_response)
         end
         targetLinks
       else
         raise response.response
      end
    end

    def parse_response
      # Only one user should be returns every time
      userData = self.response["MembersList"][0]

      self.isActive = userData["IsActive"]
      self.isAdmin = userData["IsAdmin"]
      self.isSuperuser = userData["IsSuperuser"]
      self.name = userData["KeyName"]
      self.languageID = userData["LanguageID"]
      self.longname = userData["Longname"]
      self.mail = userData["MailAddress"]
    end
  end
end
