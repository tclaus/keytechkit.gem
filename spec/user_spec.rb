module KeytechKit
  RSpec.describe KeytechKit do
    context 'user handling' do
      it 'loads current user' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        current_user = keytech_kit.current_user
        expect(current_user).not_to be nil
        expect(current_user.name).to eq(DEMO_USER)
      end

      it 'loads current user favorites' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        current_user = keytech_kit.current_user
        expect(current_user).not_to be nil
        expect(current_user.name).to eq(DEMO_USER)

        favorites = keytech_kit.current_user.favorites

        expect(favorites).not_to be nil
      end

      it 'loads current user queries' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        current_user = keytech_kit.current_user
        expect(current_user).not_to be nil
        expect(current_user.name).to eq(DEMO_USER)

        queries = keytech_kit.current_user.queries
        expect(queries).not_to be nil
      end
    end
  end
end
