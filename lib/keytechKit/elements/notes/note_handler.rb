require 'keytechKit/elements/notes/note'

module KeytechKit
  ##
  # Notes
  class NoteHandler
    include HTTParty

    def initialize(base_url, username, password)
      self.class.base_uri(base_url)
      @auth = { username: username, password: password }
    end

    def load(elementKey)
      parameter = { basic_auth: @auth }

      response = self.class.get("/elements/#{elementKey}/notes", parameter)
      if response.success?
        parse_notes(response['NotesList'])
      else
        raise response.response
      end
    end

    private

    def parse_notes(notesResult)
      notes = []
      notesResult.each do |notedata|
        notes.push Note.new(notedata)
      end
      notes
    end
  end
end
