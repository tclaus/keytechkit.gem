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

    def load(user)
      options = {}
      options.merge!(basic_auth: @auth)
      response = self.class.get("/user/#{user}", options)
      if response.success?
         self.response = response
         parse_response
         self
       else
         raise response.response
      end
    end

private
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
