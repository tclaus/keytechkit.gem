module KeytechKit
  RSpec.describe KeytechKit do

    ElementWithFiles = "3DMISC_SLDASM:500089"

    it "loads a files object" do
        keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
        files = keytechKit.files
        expect(files).not_to be nil
    end

    it "find the filelist" do
        keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
        files = keytechKit.files
        expect(files).not_to be nil

        filesList = files.load(ElementWithFiles)
        expect(filesList).not_to be nil
        expect(filesList.length).to be > 0
    end

    it "find the masterfile" do
        keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
        files = keytechKit.files
        expect(files).not_to be nil

        masterfile = files.loadMasterfile(ElementWithFiles)
        expect(masterfile).not_to be nil
        # The masterfileID can be downloaded
    end

    it "element has a masterfile" do
        keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
        files = keytechKit.files
        expect(files).not_to be nil

        hasMasterfile = files.hasMasterfile(ElementWithFiles)
        expect(hasMasterfile).to be true
        # The masterfileID can be downloaded
    end

    it "element has no masterfile" do
        keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
        files = keytechKit.files
        expect(files).not_to be nil

        hasMasterfile = files.hasMasterfile("default_mi:123")

        expect(hasMasterfile).to be false
    end

    it "loads the masterfile fileinfos" do
        keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
        files = keytechKit.files
        expect(files).not_to be nil

        masterfileInfo = files.masterfileInfo(ElementWithFiles)
        puts "FileInfo: #{masterfileInfo}"
        expect(masterfileInfo).not_to be nil
        # The masterfileID can be downloaded
    end

    it "loads the masterfile filename" do
        keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
        files = keytechKit.files
        expect(files).not_to be nil

        masterfilename = files.masterfilename(ElementWithFiles)
        puts "FileName: #{masterfilename}"
        expect(masterfilename).not_to be nil
        # The masterfileID can be downloaded
    end


  end
end
