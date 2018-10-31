module KeytechKit
  RSpec.describe KeytechKit do
    ElementWithNotes = 'DEFAULT_MI:550194'.freeze

    it 'loads a notes object' do
      keytechKit = Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
      notes = keytechKit.notes
      expect(notes).not_to be nil
    end

    it 'find the notes' do
      keytechKit = Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
      notes = keytechKit.notes
      expect(notes).not_to be nil

      steamroller = notes.load(ElementWithNotes)
      expect(steamroller).not_to be nil
    end
  end
end
