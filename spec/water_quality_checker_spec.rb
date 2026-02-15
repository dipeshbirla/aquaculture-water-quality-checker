require "rspec"
require_relative "../lib/aquaculture/water_quality_checker"
require_relative "../lib/aquaculture/sensor_reading"

RSpec.describe WaterQualityChecker do
  subject(:checker) { described_class.new(profile) }

  # Mock profile with specific thresholds for testing
  let(:profile) { double("Profile", thresholds:) }

  let(:thresholds) do
    {
      temperature: { min: 12.0, max: 18.0 },
      ph: { min: 6.5, max: 8.5 },
      dissolved_oxygen: { min: 7.0 }
    }
  end

  # Default sensor values (valid state)
  let(:temperature) { 15.0 }
  let(:ph) { 7.2 }
  let(:dissolved_oxygen) { 8.0 }

  let(:reading) do
    SensorReading.new(
      temperature: temperature,
      ph: ph,
      dissolved_oxygen: dissolved_oxygen
    )
  end

  describe "#check" do
    context "when all readings are within limits" do
      it "returns no alerts" do
        expect(checker.check(reading)).to eq([])
      end
    end

    context "when temperature is below minimum" do
      let(:temperature) { 10.0 }

      it "returns a low temperature alert" do
        expect(checker.check(reading)).to eq(
          ["Temperature too low: 10.0°C (min: 12.0°C)"]
        )
      end
    end

    context "when temperature exceeds maximum" do
      let(:temperature) { 20.0 }

      it "returns a high temperature alert" do
        expect(checker.check(reading)).to eq(
          ["Temperature too high: 20.0°C (max: 18.0°C)"]
        )
      end
    end

    context "when pH is too low" do
      let(:ph) { 6.0 }

      it "formats pH correctly in alert" do
        expect(checker.check(reading)).to eq(
          ["pH too low: 6.0 (min: 6.5)"]
        )
      end
    end

    context "when dissolved oxygen is too low" do
      let(:dissolved_oxygen) { 5.0 }

      it "returns dissolved oxygen alert with unit" do
        expect(checker.check(reading)).to eq(
          ["Dissolved oxygen too low: 5.0 mg/L (min: 7.0 mg/L)"]
        )
      end
    end

    context "when multiple parameters violate thresholds" do
      let(:temperature) { 22.0 }
      let(:ph) { 6.0 }
      let(:dissolved_oxygen) { 5.0 }

      it "returns all applicable alerts" do
        expect(checker.check(reading)).to match_array(
          [
            "Temperature too high: 22.0°C (max: 18.0°C)",
            "pH too low: 6.0 (min: 6.5)",
            "Dissolved oxygen too low: 5.0 mg/L (min: 7.0 mg/L)"
          ]
        )
      end
    end

    context "when a parameter has no max limit" do
      let(:thresholds) do
        {
          dissolved_oxygen: { min: 7.0 }
        }
      end

      let(:dissolved_oxygen) { 10.0 }

      it "does not generate a high alert" do
        expect(checker.check(reading)).to eq([])
      end
    end
  end
end
