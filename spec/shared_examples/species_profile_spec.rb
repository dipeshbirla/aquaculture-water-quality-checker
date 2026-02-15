RSpec.shared_examples "a species profile" do |expected_thresholds|
  subject(:profile) { described_class.new }

  describe "#thresholds" do
    let(:thresholds) { profile.thresholds }

    it "returns a hash" do
      expect(thresholds).to be_a(Hash)
    end

    it "has the expected parameters" do
      expect(thresholds.keys).to contain_exactly(*expected_thresholds.keys)
    end

    it "matches the expected threshold values" do
      expect(thresholds).to eq(expected_thresholds)
    end

    it "uses numeric values for all limits" do
      thresholds.each_value do |limits|
        limits.each_value do |value|
          expect(value).to be_a(Numeric)
        end
      end
    end
  end
end
