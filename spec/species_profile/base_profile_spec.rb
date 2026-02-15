require "rspec"
require_relative "../../lib/aquaculture/species_profile/base_profile"

RSpec.describe BaseProfile do
  subject(:profile) { described_class.new }

  describe "#thresholds" do
    it "raises NotImplementedError" do
      expect {
        profile.thresholds
      }.to raise_error(
        NotImplementedError,
        "BaseProfile must implement #thresholds"
      )
    end
  end
end
