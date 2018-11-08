module KeytechKit
  RSpec.describe KeytechKit do
    context 'Elements' do
      it 'loads a element object' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        elements = keytech_kit.element_handler
        expect(elements).not_to be nil
      end

      it 'find the steamroller element' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        elements = keytech_kit.element_handler
        expect(elements).not_to be nil

        steamroller = elements.load(DEMO_ARTICLE)
        expect(steamroller).not_to be nil
      end

      it 'loads the steamroller element with full keyvaluelist' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        elements = keytech_kit.element_handler
        expect(elements).not_to be nil

        steamroller = elements.load(DEMO_ARTICLE, attributes: 'all')
        expect(steamroller).not_to be nil
        expect(steamroller.keyValueList).not_to be nil
        expect(steamroller.keyValueList.length).to be > 0
      end

      it 'loads the steamroller preview' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        elements = keytech_kit.element_handler
        expect(elements).not_to be nil
        steamroller = elements.load(DEMO_ARTICLE, attributes: 'all')
        expect(steamroller).not_to be nil
        expect(elements.preview(steamroller.key)).not_to be nil
      end

      it 'loads the steamroller thumbnail' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        elements = keytech_kit.element_handler
        expect(elements).not_to be nil
        steamroller = elements.load(DEMO_ARTICLE, attributes: 'all')
        expect(steamroller).not_to be nil
        expect(elements.thumbnail(steamroller.key)).not_to be nil
      end

      it 'loads the steamroller structure' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        elements = keytech_kit.element_handler
        expect(elements).not_to be nil
        structure = elements.structure(DEMO_ARTICLE)
        expect(structure).not_to be nil
        expect(structure.length).to be > 0
      end

      it 'loads the steamroller parents' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        elements = keytech_kit.element_handler
        expect(elements).not_to be nil
        structure = elements.structure(DEMO_ARTICLE)
        expect(structure).not_to be nil
        expect(structure.length).to be > 0
        parents = elements.whereused(structure.first.key)
        expect(parents.length).to be == 1
      end

      it 'creates a dummy element' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        elements = keytech_kit.element_handler
        element = elements.new_element('MISC_FILE')
        expect(element).not_to be nil
        expect(element.keyValueList).not_to be nil
      end

      it 'stores and deletes a dummy element' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        elements = keytech_kit.element_handler
        element = elements.new_element('MISC_FILE')
        saved_element = elements.save(element)
        expect(saved_element).not_to be nil

        delete_response = elements.delete(saved_element.key)
        expect(delete_response.success?).to be true
        expect(delete_response.code).to be 200
      end

      it 'stores and deletes an element with keyValueList' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        elements = keytech_kit.element_handler
        element = elements.new_element('MISC_FILE')
        element.keyValueList['au_do__u_description_do_1_de'] = 'Dies ist ein test - Element'

        saved_element = elements.save(element)

        expect(saved_element).not_to be nil

        delete_response = elements.delete(saved_element.key)
        expect(delete_response.success?).to be true
      end

      it 'loads a already deleted element without troubles - not' do
        # Will load an element, that has been deleted.
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        elements = keytech_kit.element_handler
        element = elements.new_element('MISC_FILE')
        element.keyValueList['au_do__u_description_do_1_de'] = 'Dies ist ein test - Element'

        saved_element = elements.save(element)

        expect(saved_element).not_to be nil

        delete_response = elements.delete(saved_element.key)
        expect(delete_response.success?).to be true

        # Load again
        ghost_element = elements.load(saved_element.key)
        expect(ghost_element).to be nil
      end
    end
  end
end
