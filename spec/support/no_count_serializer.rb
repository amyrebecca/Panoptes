shared_examples "a no count serializer" do
  let(:scope) { resource.class.all }
  let(:lookup) { resource.model_name.plural.to_sym }

  describe "avoid heavy count queries on paging" do
    it "should manually deal with the paging information" do
      result = described_class.page({}, scope, {})
      meta = result[:meta][lookup]
      expect(meta[:count]).to eq(0)
      expect(meta[:page_count]).to eq(0)
      expect(meta[:previous_page]).to eq(0)
      expect(meta[:next_page]).to eq(2)
    end

    it "should handle the the previous page information" do
      result = described_class.page({page: 2}, scope, {})
      meta = result[:meta][lookup]
      expect(meta[:count]).to eq(0)
      expect(meta[:page_count]).to eq(0)
      expect(meta[:previous_page]).to eq(1)
      expect(meta[:next_page]).to eq(3)
    end
  end
end