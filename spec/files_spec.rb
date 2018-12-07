module KeytechKit
  RSpec.describe KeytechKit do
    ELEMENT_WITH_FILES = '3DMISC_SLDASM:500089'.freeze
    context 'File handling' do
      it 'loads a files object' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        files = keytech_kit.element_handler.file_handler
        expect(files).not_to be nil
      end

      it 'find the filelist' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        files = keytech_kit.element_handler.file_handler
        expect(files).not_to be nil

        files_list = files.load(ELEMENT_WITH_FILES)
        expect(files_list).not_to be nil
        expect(files_list.length).to be > 0
      end
    end
    context 'Masterfile handling' do
      it 'find the masterfile' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        files = keytech_kit.element_handler.file_handler
        expect(files).not_to be nil

        masterfile = files.load_masterfile(ELEMENT_WITH_FILES)
        expect(masterfile).not_to be nil
        # The masterfileID can be downloaded
      end

      it 'element has a masterfile' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        files = keytech_kit.element_handler.file_handler
        expect(files).not_to be nil

        hasMasterfile = files.masterfile?(ELEMENT_WITH_FILES)
        expect(hasMasterfile).to be true
        # The masterfileID can be downloaded
      end

      it 'element has no masterfile' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        files = keytech_kit.element_handler.file_handler
        expect(files).not_to be nil

        hasMasterfile = files.masterfile?('default_mi:123')

        expect(hasMasterfile).to be false
      end

      it 'loads the masterfile fileinfos' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        files = keytech_kit.element_handler.file_handler
        expect(files).not_to be nil

        masterfile_info = files.masterfile_info(ELEMENT_WITH_FILES)
        puts "FileInfo: #{masterfile_info}"
        expect(masterfile_info).not_to be nil
        # The masterfileID can be downloaded
      end

      it 'loads the masterfile filename' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        files = keytech_kit.element_handler.file_handler
        expect(files).not_to be nil

        masterfilename = files.masterfile_name(ELEMENT_WITH_FILES)
        puts "FileName: #{masterfilename}"
        expect(masterfilename).not_to be nil
        # The masterfileID can be downloaded
      end
    end
    context 'File Upload' do
      it 'uploads a file' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        # create a dummy File.read(elements = keytechKit.elements
        element = keytech_kit.element_handler.new_element('MISC_FILE')
        element = keytech_kit.element_handler.save(element)

        file = File.new('spec/fixtures/image_file.jpg')
        file_handler = keytech_kit.element_handler.file_handler
        result = file_handler.upload_masterfile(element.key, file, 'image_file.jpg')
        expect(result[:success]).to be true

        result = file_handler.upload_preview(element.key, file, 'thumbnail.jpg')
        expect(result[:success]).to be true

        result = file_handler.upload_quickpreview(element.key, file, 'thumbnail.jpg')
        expect(result[:success]).to be true

        keytech_kit.element_handler.delete(element.key)
        # delete after upload
      end

      it 'removes a file' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        # create a dummy File.read(elements = keytechKit.elements
        element = keytech_kit.element_handler.new_element('MISC_FILE')
        element = keytech_kit.element_handler.save(element)

        file = File.new('spec/fixtures/image_file.jpg')
        file_handler = keytech_kit.element_handler.file_handler
        result = file_handler.upload_masterfile(element.key, file, 'image_file.jpg')
        expect(result[:success]).to be true

        result = file_handler.upload_preview(element.key, file, 'thumbnail.jpg')
        expect(result[:success]).to be true

        result = file_handler.upload_quickpreview(element.key, file, 'thumbnail.jpg')
        expect(result[:success]).to be true

        # Remove files here
        result = file_handler.delete_quickpreview(element.key)
        puts "resut: #{result.inspect}"
        expect(result[:success]).to be true

        result = file_handler.delete_preview(element.key)
        expect(result[:success]).to be true

        result = file_handler.delete_masterfile(element.key)
        expect(result[:success]).to be true

        # Clean test element
        keytech_kit.element_handler.delete(element.key)
      end
    end
  end
end
