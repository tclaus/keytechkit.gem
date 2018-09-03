module KeytechKit
  RSpec.describe KeytechKit do

    it "loads a layouts object" do
        keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
        layouts = keytechKit.layouts
        expect(layouts).not_to be nil
    end

    it "loads main layout" do
      keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
      layouts = keytechKit.layouts
      expect(layouts).not_to be nil

      # Possible filetypes
      # Product_wf, misc_file, default_mi
      classkey = "PRODUCT_WF"
      layout = layouts.main_layout(classkey)
      expect(layout).not_to be nil
      expect(layout.controls).not_to be nil
      expect(layout.controls.length).to be >0
    end

    it "loads header layout" do
      keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
      layouts = keytechKit.layouts
      expect(layouts).not_to be nil

      # Possible filetypes
      # Product_wf, misc_file, default_mi
      classkey = "PRODUCT_WF"
      layout = layouts.header_layout(classkey)
      expect(layout).not_to be nil
      expect(layout.controls).not_to be nil
      puts "Header Layout controlcount: #{layout.controls.length}"
      # expect(layout.controls.length).to be >0
    end

    it "loads explorer layout" do
      keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
      layouts = keytechKit.layouts
      expect(layouts).not_to be nil

      # Possible filetypes
      # Product_wf, misc_file, default_mi
      classkey = "PRODUCT_WF"
      layout = layouts.explorer_layout(classkey)
      expect(layout).not_to be nil
      expect(layout.controls).not_to be nil
      puts "Explorer Layout controlcount: #{layout.controls.length}"
      # expect(layout.controls.length).to be >0
    end

  end
end
