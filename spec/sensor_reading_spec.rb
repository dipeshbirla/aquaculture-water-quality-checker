require "rspec"
require_relative "../lib/aquaculture/sensor_reading"

RSpec.describe SensorReading do
  subject(:reading) do
    described_class.new(temperature:, ph:, dissolved_oxygen:)
  end

  let(:temperature) { 20.5 }
  let(:ph) { 7.2 }
  let(:dissolved_oxygen) { 6.8 }

  describe "#initialize" do
    context "with valid inputs" do
      it "assigns attributes correctly" do
        expect(reading.temperature).to eq(temperature)
        expect(reading.ph).to eq(ph)
        expect(reading.dissolved_oxygen).to eq(dissolved_oxygen)
      end
    end

    context "when values are zero" do
      let(:temperature) { 0.0 }
      let(:ph) { 0.0 }
      let(:dissolved_oxygen) { 0.0 }

      it "accepts zero values" do
        expect(reading.temperature).to eq(0.0)
        expect(reading.ph).to eq(0.0)
        expect(reading.dissolved_oxygen).to eq(0.0)
      end
    end

    context "when values are negative" do
      let(:temperature) { -5.0 }
      let(:ph) { -1.0 }
      let(:dissolved_oxygen) { -3.0 }

      it "accepts negative values" do
        expect(reading.temperature).to eq(-5.0)
        expect(reading.ph).to eq(-1.0)
        expect(reading.dissolved_oxygen).to eq(-3.0)
      end
    end

    context "when values are integers" do
      let(:temperature) { 20 }
      let(:ph) { 7 }
      let(:dissolved_oxygen) { 6 }

      it "accepts integer values" do
        expect(reading.temperature).to eq(20)
        expect(reading.ph).to eq(7)
        expect(reading.dissolved_oxygen).to eq(6)
      end
    end

    context "when required arguments are missing" do
      it "raises error if temperature is missing" do
        expect {
          described_class.new(ph:, dissolved_oxygen:)
        }.to raise_error(ArgumentError)
      end

      it "raises error if ph is missing" do
        expect {
          described_class.new(temperature:, dissolved_oxygen:)
        }.to raise_error(ArgumentError)
      end

      it "raises error if dissolved_oxygen is missing" do
        expect {
          described_class.new(temperature:, ph:)
        }.to raise_error(ArgumentError)
      end
    end

    context "when extra arguments are passed" do
      it "raises an ArgumentError" do
        expect {
          described_class.new(
            temperature:,
            ph:,
            dissolved_oxygen:,
            salinity: 30
          )
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe "immutability" do
    it "does not allow attribute modification" do
      expect {
        reading.temperature = 25.0
      }.to raise_error(NoMethodError)
    end
  end
end
