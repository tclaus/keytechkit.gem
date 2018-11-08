module KeytechKit
  RSpec.describe KeytechKit do
    context 'Class Layouts' do
      it 'loads a layouts object' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        layouts = keytech_kit.layouts
        expect(layouts).not_to be nil
      end

      it 'loads main layout' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        layouts = keytech_kit.layouts
        expect(layouts).not_to be nil

        # Possible filetypes
        # Product_wf, misc_file, default_mi
        classkey = 'PRODUCT_WF'
        layout = layouts.main_layout(classkey)
        expect(layout).not_to be nil
        expect(layout.controls).not_to be nil
        expect(layout.controls.length).to be > 0
      end

      it 'loads header layout' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        layouts = keytech_kit.layouts
        expect(layouts).not_to be nil

        # Possible filetypes
        # Product_wf, misc_file, default_mi
        classkey = 'PRODUCT_WF'
        layout = layouts.header_layout(classkey)
        expect(layout).not_to be nil
        expect(layout.controls).not_to be nil
      end

      it 'loads explorer layout' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        layouts = keytech_kit.layouts
        expect(layouts).not_to be nil

        # Possible filetypes
        # Product_wf, misc_file, default_mi
        classkey = 'PRODUCT_WF'
        layout = layouts.explorer_layout(classkey)
        expect(layout).not_to be nil
        expect(layout.controls).not_to be nil
      end

      it 'loads lister layout' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        layouts = keytech_kit.layouts
        expect(layouts).not_to be nil

        classkey = 'PRODUCT_WF'
        layout = layouts.lister_layout(classkey)
        expect(layout).not_to be nil
        expect(layout.controls).not_to be nil
      end

      it 'loads bom lister layout' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        layouts = keytech_kit.layouts
        expect(layouts).not_to be nil

        layout = layouts.bom_lister_layout
        expect(layout).not_to be nil
        expect(layout.controls).not_to be nil
      end

      it 'loads global lister layout' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        layouts = keytech_kit.layouts
        expect(layouts).not_to be nil

        layout = layouts.global_lister_layout
        expect(layout).not_to be nil
        expect(layout.controls).not_to be nil
        expect(layout.controls.length).to be > 0
      end
    end
  end
end
