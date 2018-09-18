module KeytechKit
  RSpec.describe KeytechKit do

    it "loads current user" do
        keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
        currentUser = keytechKit.currentUser
        expect(currentUser).not_to be nil
        expect(currentUser.name).to eq(KeytechKit::DEMO_USER)
    end

    it "loads current user favorites" do
        keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
        currentUser = keytechKit.currentUser
        expect(currentUser).not_to be nil
        expect(currentUser.name).to eq(KeytechKit::DEMO_USER)

        favorites = keytechKit.currentUser.favorites

        expect(favorites).not_to be nil
    end

    it "loads current user queries" do
        keytechKit =  Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
        currentUser = keytechKit.currentUser
        expect(currentUser).not_to be nil
        expect(currentUser.name).to eq(KeytechKit::DEMO_USER)

        queries = keytechKit.currentUser.queries
        expect(queries).not_to be nil
    end

  end
end
