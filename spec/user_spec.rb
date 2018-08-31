module KeytechKit
  RSpec.describe KeytechKit do

  username = "jgrant"
  password = ""

  it "loads current user" do
      keytechKit =  Keytech_Kit.new("https://demo.keytech.de", username, password)
      currentUser = keytechKit.currentUser
      expect(currentUser).not_to be nil
      expect(currentUser.name).to eq(username)
  end

  it "loads current user favorites" do
      keytechKit =  Keytech_Kit.new("https://demo.keytech.de", username, password)
      currentUser = keytechKit.currentUser
      expect(currentUser).not_to be nil
      expect(currentUser.name).to eq(username)

      favorites = keytechKit.currentUser.favorites

      expect(favorites).not_to be nil
  end

  it "loads current user queries" do
      keytechKit =  Keytech_Kit.new("https://demo.keytech.de", username, password)
      currentUser = keytechKit.currentUser
      expect(currentUser).not_to be nil
      expect(currentUser.name).to eq(username)

      favorites = keytechKit.currentUser.queries
      puts "Favorites: #{favorites}"
      expect(favorites).not_to be nil
  end

end
end
