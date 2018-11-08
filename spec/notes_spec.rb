module KeytechKit
  RSpec.describe KeytechKit do
    ELEMENT_WITH_NOTES = 'DEFAULT_MI:550194'.freeze
    context 'Element Notes' do
      it 'loads a notes object' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        notes = keytech_kit.element_handler.note_handler
        expect(notes).not_to be nil
      end

      it 'find the notes' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        notes = keytech_kit.element_handler.note_handler
        expect(notes).not_to be nil

        steamroller = notes.load(ELEMENT_WITH_NOTES)
        expect(steamroller).not_to be nil
      end
    end
  end
end
