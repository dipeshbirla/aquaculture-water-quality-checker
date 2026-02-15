require "rspec"
require_relative "../../lib/aquaculture/species_profile/base_profile"
require_relative "../../lib/aquaculture/species_profile/salmon_profile"
require_relative "../shared_examples/species_profile_spec"

RSpec.describe SalmonProfile do
  it_behaves_like "a species profile",
    {
      temperature: { min: 12, max: 18 },
      ph: { min: 6.5, max: 8.5 },
      dissolved_oxygen: { min: 7 }
    }
end
