module KeytechKit
  RSpec.describe KeytechKit do
    it 'loads the folders mails' do
      keytechKit = Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
      elements = keytechKit.elements
      expect(elements).not_to be nil
      mails = elements.mails('FOLDER_WF:2009625')
      expect(mails).not_to be nil
      expect(mails.length).to be > 0
    end
  end
end
