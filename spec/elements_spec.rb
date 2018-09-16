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

        steamroller = elements.load(KeytechKit::DEMO_ARTICLE)
        expect(steamroller).not_to be nil
    end

    it "loads the steamroller element with full keyvaluelist" do
        keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
        elements = keytechKit.elements
        expect(elements).not_to be nil

        steamroller = elements.load(KeytechKit::DEMO_ARTICLE, {"attributes":"all"})
        expect(steamroller).not_to be nil
        expect(steamroller.keyValueList).not_to be nil
        expect(steamroller.keyValueList.length).to be > 0
    end

    it "loads the steamroller preview" do
        keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
        elements = keytechKit.elements
        expect(elements).not_to be nil
        steamroller = elements.load(KeytechKit::DEMO_ARTICLE, {"attributes":"all"})
        expect(steamroller).not_to be nil
        expect(elements.preview(steamroller.key)).not_to be nil
    end

    it "loads the steamroller thumbnail" do
        keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
        elements = keytechKit.elements
        expect(elements).not_to be nil
        steamroller = elements.load(KeytechKit::DEMO_ARTICLE, {"attributes":"all"})
        expect(steamroller).not_to be nil
        expect(elements.thumbnail(steamroller.key)).not_to be nil
    end

    it "loads the steamroller structure" do
        keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
        elements = keytechKit.elements
        expect(elements).not_to be nil
        structure = elements.structure(DEMO_ARTICLE)
        expect(structure).not_to be nil
        expect(structure.length).to be > 0
    end

    it "loads the steamroller parents" do
        keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
        elements = keytechKit.elements
        expect(elements).not_to be nil
        structure = elements.structure(DEMO_ARTICLE)
        expect(structure).not_to be nil
        expect(structure.length).to be > 0
        parents = elements.whereused(structure.first.key)
        expect(parents.length).to be == 1
    end

  end
end