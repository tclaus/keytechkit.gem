module KeytechKit
  RSpec.describe KeytechKit do
    ELEMENT_WITH_NOTES = 'DEFAULT_MI:550194'.freeze
    context 'Element Notes' do
      it 'loads a notes object' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        note_handler = keytech_kit.element_handler.note_handler
        expect(note_handler).not_to be nil
      end

      it 'find the notes' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        note_handler = keytech_kit.element_handler.note_handler
        expect(note_handler).not_to be nil

        element_notes = note_handler.load(ELEMENT_WITH_NOTES)
        expect(element_notes).not_to be nil
      end

      it 'loads note types' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        note_handler = keytech_kit.element_handler.note_handler
        expect(note_handler).not_to be nil
        note_types = note_handler.load_note_types
        expect(note_types).not_to be_empty
      end

      it 'add and remove a note' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        note_handler = keytech_kit.element_handler.note_handler
        note_type = 'WEB'
        note = note_handler.create(note_type, ELEMENT_WITH_NOTES)
        note.subject = 'This is the respec test note'
        note.text = 'This is the notes body. Curently only plaintext'
        result = note_handler.save(note) # Save wil create a new note or update an
        #  existing one
        expect(result[:success]).to be true
        note_id = result[:id]
        note.id = note_id
        expect(note_id).not_to be eq(0)
        result = note_handler.remove(note)
        expect(result[:success]).to be(true)
      end
    end
  end
end
