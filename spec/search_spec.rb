module KeytechKit
  RSpec.describe KeytechKit do
    context 'Searches Fulltext' do
      it 'loads the search object' do
        keytech_kit = KeytechKit.new(DEMO_URL)
        search = keytech_kit.search
        expect(search).not_to be nil
      end

      it 'executes a fulltext query' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        elements = keytech_kit.search.query(q: 'demo')
        expect(elements).not_to be nil
        expect(elements.elementList.length).to be > 10
      end

      it 'executes a fulltext query with pages' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        elements = keytech_kit.search.query(q: 'demo', page: 1, size: 1)
        expect(elements).not_to be nil
        expect(elements.elementList.length).to be == 1
      end

      it 'executes a fulltext query with group by ' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        elements = keytech_kit.search.query(q: 'demo', groupBy: 'classkey')
        expect(elements).not_to be nil

        expect(elements.groupBy).not_to be nil
        expect(elements.groupBy.values.length).to be > 1
      end
    end
    context 'Search with parameters' do
      it 'executes a query with fields (created_by = pmiller) ' do
        keytech_kit = KeytechKit.new(DEMO_URL, DEMO_USER, DEMO_PASSWORD)
        elements = keytech_kit.search.query(fields: 'created_by=pmiller:changed_by=pmiller', size: 2)
        expect(elements).not_to be nil
        expect(elements.elementList.length).to be > 1
      end
    end
  end
end
