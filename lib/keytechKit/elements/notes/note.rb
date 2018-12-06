module KeytechKit
  ##
  # A single note
  class Note
    attr_accessor :changedAt
    attr_accessor :changedBy
    attr_accessor :changedByLong
    attr_accessor :createdAt
    attr_accessor :createdBy
    attr_accessor :createdByLong
    attr_accessor :id
    attr_accessor :note_type
    attr_accessor :subject
    attr_accessor :text
    attr_accessor :element_key

    def initialize(data)
      @changedAt = data['ChangedAt']
      @changedBy = data['ChangedBy']
      @changedByLong = data['ChangedByLong']

      @createdAt = data['CreatedAt']
      @createdBy = data['CreatedBy']
      @createdByLong = data['CreatedByLong']

      @id = data['ID'] || 0
      @note_type = data['NoteType']
      @subject = data['Subject']
      @text = data['Text']
    end

    def to_hash
      { NoteType: @note_type, Subject: @subject, Text: @text }
    end
  end
end
