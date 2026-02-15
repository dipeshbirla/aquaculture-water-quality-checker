require "rspec"
require_relative "../../lib/aquaculture/species_profile/base_profile"
require_relative "../../lib/aquaculture/species_profile/tilapia_profile"
require_relative "../shared_examples/species_profile_spec"

RSpec.describe TilapiaProfile do
  it_behaves_like "a species profile",
    {
      temperature: { min: 25, max: 30 },
      ph: { min: 6.5, max: 9.0 },
      dissolved_oxygen: { min: 5 }
    }
end
