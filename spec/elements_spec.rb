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

    it "loads the steamroller bill of material (BOM)" do
        keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
        elements = keytechKit.elements
        expect(elements).not_to be nil
        bom = elements.billOfMaterial(DEMO_ARTICLE,{"attributes":"lister"})
        expect(bom).not_to be nil
        expect(bom.length).to be > 0
    end

    it "creates a dummy element" do
      keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
      elements = keytechKit.elements
      element = elements.newElement("MISC_FILE")
      expect(element).not_to be nil
      expect(element.keyValueList).not_to be nil
    end

    it "stores and deletes a dummy element" do
      keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
      elements = keytechKit.elements
      element = elements.newElement("MISC_FILE")
      saved_element = elements.save(element)
      expect(saved_element).not_to be nil

      delete_response = elements.delete(saved_element.key)
      expect(delete_response.success?).to be true
      expect(delete_response.code).to be 200
    end

# Create and store keyValue lists
# au_do__u_description_do_1_de

  it "stores and deletes an element with keyValueList" do
    keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
    elements = keytechKit.elements
    element = elements.newElement("MISC_FILE")
    element.keyValueList["au_do__u_description_do_1_de"] = "Dies ist ein test - Element"

    saved_element = elements.save(element)

    expect(saved_element).not_to be nil

    delete_response = elements.delete(saved_element.key)
    expect(delete_response.success?).to be true
  end


  end
end
