module KeytechKit
  RSpec.describe KeytechKit do

    it "loads a classes object" do
        keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
        classes = keytechKit.classes
        expect(classes).not_to be nil
    end

    it "loads a classdefinition object" do
      keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
      classes = keytechKit.classes
      expect(classes).not_to be nil

      # Possible filetypes
      # Product_wf, misc_file, default_mi
      classkey = "PRODUCT_WF"
      productDefinition = classes.classDefinition(classkey)
      expect(productDefinition).not_to be nil
      expect(productDefinition.classKey).to eq(classkey)
      expect(productDefinition.availableSubareas).not_to be nil

      classkey = "MISC_FILE"
      productDefinition = classes.classDefinition(classkey)
      expect(productDefinition).not_to be nil
      expect(productDefinition.classKey).to eq(classkey)

      classkey = "DEFAULT_MI"
      productDefinition = classes.classDefinition(classkey)
      expect(productDefinition).not_to be nil
      expect(productDefinition.classKey).to eq(classkey)

    end

  end
end
