module KeytechKit
  RSpec.describe KeytechKit do
    it 'loads the search object' do
      keytechKit = Keytech_Kit.new(KeytechKit::DEMO_URL)
      search = keytechKit.search
      expect(search).not_to be nil
    end

    it 'executes a fulltext query' do
      keytechKit = Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
      elements = keytechKit.search.query(q: 'demo')
      expect(elements).not_to be nil
      expect(elements.elementList.length).to be > 10
    end

    it 'executes a fulltext query with pages' do
      keytechKit = Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
      elements = keytechKit.search.query(q: 'demo', page: 1, size: 1)
      expect(elements).not_to be nil
      expect(elements.elementList.length).to be == 1
    end

    it 'executes a fulltext query with group by ' do
      keytechKit = Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
      elements = keytechKit.search.query(q: 'demo', groupBy: 'classkey')
      expect(elements).not_to be nil

      expect(elements.groupBy).not_to be nil
      expect(elements.groupBy.values.length).to be > 1
    end

    it 'executes a query with fields (created_by = pmiller) ' do
      keytechKit = Keytech_Kit.new(KeytechKit::DEMO_URL, KeytechKit::DEMO_USER, KeytechKit::DEMO_PASSWORD)
      elements = keytechKit.search.query(fields: 'created_by=pmiller:changed_by=pmiller', size: 2)
      expect(elements).not_to be nil
      expect(elements.elementList.length).to be > 1
    end
  end
end
