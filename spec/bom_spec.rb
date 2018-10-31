module KeytechKit
  RSpec.describe KeytechKit do

    it "loads the steamroller bill of material (BOM)" do
        keytechKit = Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
        elements = keytechKit.elements
        expect(elements).not_to be nil
        bom = elements.billOfMaterial(DEMO_ARTICLE, { attributes: 'lister' })
        expect(bom).not_to be nil
        expect(bom.length).to be > 0
        bomElement = bom[0]
        expect(bomElement.key).not_to be nil
        expect(bomElement.elementKey).not_to be nil
    end
  end
end
