module KeytechKit
  RSpec.describe KeytechKit do
    context 'Data Dictionaries' do
      DDID_WITH_DATA = 800_179

      it 'loads a data dictionary object' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        data_dictionaries = keytech_kit.data_dictionary_handler
        expect(data_dictionaries).not_to be nil
      end

      it 'loads a data dictionary definition' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        data_dictionaries = keytech_kit.data_dictionary_handler
        expect(data_dictionaries).not_to be nil
        definition = data_dictionaries.getDefinition(DDID_WITH_DATA)
        expect(definition).not_to be nil
        expect(definition.size).to be > 0
      end

      it 'loads a data dictionary data' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        data_dictionaries = keytech_kit.data_dictionary_handler
        expect(data_dictionaries).not_to be nil
        data = data_dictionaries.getData(DDID_WITH_DATA)
        expect(data).not_to be nil
        expect(data.size).to be > 0
      end
    end
  end
end
