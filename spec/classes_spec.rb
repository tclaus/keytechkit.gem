module KeytechKit
  RSpec.describe KeytechKit do
    context 'Element Classes' do
      it 'loads a classes object' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        classes = keytech_kit.classes
        expect(classes).not_to be nil
      end

      it 'loads a classdefinition object' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        classes = keytech_kit.classes
        expect(classes).not_to be nil

        # Possible filetypes
        # Product_wf, misc_file, default_mi
        classkey = 'PRODUCT_WF'
        productDefinition = classes.load(classkey)
        expect(productDefinition).not_to be nil
        expect(productDefinition.classKey).to eq(classkey)
        expect(productDefinition.availableSubareas).not_to be nil

        classkey = 'MISC_FILE'
        productDefinition = classes.load(classkey)
        expect(productDefinition).not_to be nil
        expect(productDefinition.classKey).to eq(classkey)

        classkey = 'DEFAULT_MI'
        productDefinition = classes.load(classkey)
        expect(productDefinition).not_to be nil
        expect(productDefinition.classKey).to eq(classkey)
      end

      it 'loads all classes' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        classes = keytech_kit.classes
        expect(classes).not_to be nil

        classDefinitions = classes.loadAllClasses
        expect(classDefinitions).not_to be nil
        expect(classDefinitions.size).to be > 0
      end
    end
  end
end
