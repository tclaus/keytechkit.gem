require 'keytechKit/elements/notes/note'
require 'keytechKit/elements/notes/note_type'
module KeytechKit
  ##
  # Notes
  class NoteHandler
    include HTTParty
    default_timeout 10

    def initialize(base_url, username, password)
      self.class.base_uri(base_url)
      @auth = { username: username, password: password }
    end

    def load(element_key)
      parameter = { basic_auth: @auth }

      response = self.class.get("/elements/#{element_key}/notes", parameter)
      if response.success?
        parse_notes(response['NotesList'], element_key)
      else
        # TODO: return an error object, dont raise exception
        raise response.response
      end
    end

    def load_note_types
      parameter = { basic_auth: @auth }
      response = self.class.get('/notetypes', parameter)
      if response.success?
        parse_note_types(response['Notetypes'])
      else
        # TODO: return an error object, dont raise exception
        raise response.response
      end
    end

    def create(note_type, element_key)
      note = Note.new(NoteType: note_type)
      note.note_type = note_type
      note.element_key = element_key
      note
    end

    def save(note)
      element_key = note.element_key
      note_hash = note.to_hash
      parameter = { basic_auth: @auth,
                    body: note_hash.to_json,
                    headers: { 'Content-Type' => 'application/json; charset=utf-8 ' } }

      response = if note.id.zero?
                   self.class.post("/elements/#{element_key}/notes", parameter)
                 else
                   self.class.put("/elements/#{element_key}/notes", parameter)
                 end
      if response.success?
        note.id = response.headers['location']
        { id: response.headers['location'] }
      else
        # TODO: return an error object, dont raise exception
        raise response.response
      end
    end

    def remove(note)
      parameter = { basic_auth: @auth }
      element_key = note.element_key
      note_id = note.id
      response = self.class.delete("/elements/#{element_key}/notes/#{note_id}", parameter)
      if response.success?
        { success: true }
      else
        { success: false, error: response.headers['x-errordescription'].to_s }
      end
    end

    private

    def parse_note_types(note_types_data)
      note_types = []
      note_types_data.each do |note_type_data|
        note_type = NoteType.new(note_type_data)
        note_types.push note_type
      end
      note_types
    end

    def parse_notes(notes_result, element_key)
      notes = []
      notes_result.each do |note_data|
        note = Note.new(note_data)
        note.element_key = element_key
        notes.push note
      end
      notes
    end
  end
end
