module KeytechKit
  RSpec.describe KeytechKit do
    ElementWithFiles = '3DMISC_SLDASM:500089'.freeze

    it 'loads a files object' do
      keytechKit = Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
      files = keytechKit.files
      expect(files).not_to be nil
    end

    it 'find the filelist' do
      keytechKit = Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
      files = keytechKit.files
      expect(files).not_to be nil

      files_list = files.load(ElementWithFiles)
      expect(files_list).not_to be nil
      expect(files_list.length).to be > 0
    end

    it 'find the masterfile' do
      keytechKit = Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
      files = keytechKit.files
      expect(files).not_to be nil

      masterfile = files.load_masterfile(ElementWithFiles)
      expect(masterfile).not_to be nil
      # The masterfileID can be downloaded
    end

    it 'element has a masterfile' do
      keytechKit = Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
      files = keytechKit.files
      expect(files).not_to be nil

      hasMasterfile = files.has_masterfile(ElementWithFiles)
      expect(hasMasterfile).to be true
      # The masterfileID can be downloaded
    end

    it 'element has no masterfile' do
      keytechKit = Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
      files = keytechKit.files
      expect(files).not_to be nil

      hasMasterfile = files.has_masterfile('default_mi:123')

      expect(hasMasterfile).to be false
    end

    it 'loads the masterfile fileinfos' do
      keytechKit = Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
      files = keytechKit.files
      expect(files).not_to be nil

      masterfile_info = files.masterfile_info(ElementWithFiles)
      puts "FileInfo: #{masterfile_info}"
      expect(masterfile_info).not_to be nil
      # The masterfileID can be downloaded
    end

    it 'loads the masterfile filename' do
      keytechKit = Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
      files = keytechKit.files
      expect(files).not_to be nil

      masterfilename = files.masterfile_name(ElementWithFiles)
      puts "FileName: #{masterfilename}"
      expect(masterfilename).not_to be nil
      # The masterfileID can be downloaded
    end

    it 'uploads a file' do
      keytechKit = Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
      # create a dummy File.read(elements = keytechKit.elements
      element = keytechKit.elements.newElement('MISC_FILE')
      element = keytechKit.elements.save(element)

      file = File.new('spec/fixtures/image_file.jpg')
      result = keytechKit.files.upload_masterfile(element.key, file, 'image_file.jpg')
      expect(result[:success]).to be true

      result = keytechKit.files.upload_preview(element.key, file, 'thumbnail.jpg')
      expect(result[:success]).to be true

      result = keytechKit.files.upload_quickpreview(element.key, file, 'thumbnail.jpg')
      expect(result[:success]).to be true

      keytechKit.elements.delete(element.key)
      # delete after upload
    end

    it 'removes a file' do
      keytechKit = Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
      # create a dummy File.read(elements = keytechKit.elements
      element = keytechKit.elements.newElement('MISC_FILE')
      element = keytechKit.elements.save(element)

      file = File.new('spec/fixtures/image_file.jpg')
      result = keytechKit.files.upload_masterfile(element.key, file, 'image_file.jpg')
      expect(result[:success]).to be true

      result = keytechKit.files.upload_preview(element.key, file, 'thumbnail.jpg')
      expect(result[:success]).to be true

      result = keytechKit.files.upload_quickpreview(element.key, file, 'thumbnail.jpg')
      expect(result[:success]).to be true

      # Remove files here
      result = keytechKit.files.remove_quickpreview(element.key)
      puts "resut: #{result.inspect}"
      expect(result[:success]).to be true

      result = keytechKit.files.remove_preview(element.key)
      expect(result[:success]).to be true

      result = keytechKit.files.remove_masterfile(element.key)
      expect(result[:success]).to be true

      # Clean test element
      keytechKit.elements.delete(element.key)
    end

  end
end
