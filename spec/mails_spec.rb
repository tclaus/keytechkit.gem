module KeytechKit
  RSpec.describe KeytechKit do
    it 'loads the folders mails' do
      keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
      elements = keytech_kit.element_handler
      expect(elements).not_to be nil
      mails = elements.mails('FOLDER_WF:2009625')
      expect(mails).not_to be nil
      expect(mails.length).to be > 0
    end
  end
end
