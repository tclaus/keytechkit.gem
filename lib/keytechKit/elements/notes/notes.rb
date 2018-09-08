require 'keytechKit/elements/notes/note'

module KeytechKit
  class Notes
    include HTTParty

    def initialize(base_url, username, password)
      self.class.base_uri(base_url)
      @auth = { username: username, password: password }
    end

    def load(elementKey)
      parameter = { basic_auth: @auth }

      response = self.class.get("/elements/#{elementKey}/notes", parameter)
      puts "notes response: #{response}"
      if response.success?
        parse_notes(response["NotesList"])
       else
         raise response.response
      end
    end

    private
   def parse_notes(notesResult)
     notes = Array.new
     notesResult.each do |noteData|
        notes.push Note.new(noteData)
     end
     notes
   end
  end
end
