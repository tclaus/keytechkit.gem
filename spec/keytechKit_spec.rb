module KeytechKit
  RSpec.describe KeytechKit do
    it 'has a version number' do
      expect(KeytechKit::VERSION).not_to be nil
    end

    it 'loads serverinfo' do
      keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL)
      serverinfo = keytechKit.serverinfo
      expect(serverinfo).not_to be nil

      expect(serverinfo.database_version).to_not be nil
      expect(serverinfo.api_version).to_not be nil

      puts "API Version is #{serverinfo.api_version}"
      puts "Database Version is #{serverinfo.database_version}"
    end
  end
end
