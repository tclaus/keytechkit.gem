module KeytechKit
  RSpec.describe KeytechKit do
    context 'Bill Of Material (BOM)' do
      it 'loads the steamroller bill of material (BOM)' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        elements = keytech_kit.element_handler
        expect(elements).not_to be nil
        bom = elements.billOfMaterial(DEMO_ARTICLE, attributes: 'lister')
        expect(bom).not_to be nil
        expect(bom.length).to be > 0
        bom_element = bom[0]
        expect(bom_element.key).not_to be nil
        expect(bom_element.elementKey).not_to be nil
      end
    end
  end
end
