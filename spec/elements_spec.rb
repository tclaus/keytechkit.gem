module KeytechKit
  RSpec.describe KeytechKit do

    it "loads a element object" do
        keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
        elements = keytechKit.elements
        expect(elements).not_to be nil
    end

    it "find the steamroller element" do
        keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
        elements = keytechKit.elements
        expect(elements).not_to be nil

        steamroller = elements.find(KeytechKit::DEMO_ARTICLE)
        expect(steamroller).not_to be nil
    end

    it "loads the steamroller element with full keyvaluelist" do
        keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
        elements = keytechKit.elements
        expect(elements).not_to be nil

        steamroller = elements.find(KeytechKit::DEMO_ARTICLE, {"attributes":"all"})
        expect(steamroller).not_to be nil
        expect(steamroller.keyValueList).not_to be nil
        expect(steamroller.keyValueList.length).to be > 0
    end

  end
end
