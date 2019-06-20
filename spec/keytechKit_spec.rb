
module KeytechKit
  RSpec.describe KeytechKit do
    it 'has a version number' do
      expect(VERSION).not_to be nil
    end

    it 'loads serverinfo' do
      keytech_kit = KeytechKit.new(DEMO_URL)
      serverinfo = keytech_kit.serverinfo

      puts "ServerData: #{serverinfo.response}"

      expect(serverinfo).not_to be nil
      expect(serverinfo.database_version).to_not be nil
      expect(serverinfo.description).to_not be nil
      expect(serverinfo.api_version).to_not be nil

      puts "API Version is #{serverinfo.api_version}"
      puts "Description is #{serverinfo.description}"
      puts "Database Version is #{serverinfo.database_version}"
      # TODO: Extend serverinfos

    end
  end
end
