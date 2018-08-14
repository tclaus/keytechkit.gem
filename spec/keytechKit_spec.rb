RSpec.describe KeytechKit do

  username = "jgrant"
  password = ""


  it "has a version number" do
    expect(KeytechKit::VERSION).not_to be nil
  end

  it "loads serverinfo" do
    keytechKit =  Keytech_Kit.new("https://demo.keytech.de")
    serverinfo = keytechKit.serverinfo
    expect(serverinfo).not_to be nil

    puts serverinfo.database_version

  end

  it "executes a fulltext query" do
      puts "loads a fulltext search"
      keytechKit =  Keytech_Kit.new("https://demo.keytech.de", username, password)
      keytechKit.search("demo")
  end

  it "loads current user" do
      keytechKit =  Keytech_Kit.new("https://demo.keytech.de", username, password)

      expect(keytechKit.currentUser).not_to be nil
      puts "Loaded user: #{keytechKit.currentUser.name}"
      expect(keytechKit.currentUser.name).to eq(username)
  end

end
