module KeytechKit
  RSpec.describe KeytechKit do

  DDID_WITH_DATA = 800179

    it "loads a data dictionary object" do
        keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
        dataDictionaries = keytechKit.dataDictionaries
        expect(dataDictionaries).not_to be nil
    end

    it "loads a data dictionary definition" do
      keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
      dataDictionaries = keytechKit.dataDictionaries
      expect(dataDictionaries).not_to be nil
      definition = dataDictionaries.getDefinition(DDID_WITH_DATA)
      expect(definition).not_to be nil
      expect(definition.size).to be > 0
    end

    it "loads a data dictionary data" do
      keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
      dataDictionaries = keytechKit.dataDictionaries
      expect(dataDictionaries).not_to be nil
      data = dataDictionaries.getData(DDID_WITH_DATA)
      expect(data).not_to be nil
      expect(data.size).to be > 0
    end

  end
end
