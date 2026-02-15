require_relative "aquaculture/sensor_reading"
require_relative "aquaculture/water_quality_checker"
require_relative "aquaculture/species_profile/salmon_profile"
require_relative "aquaculture/species_profile/tilapia_profile"

# NOTE:: This file serves as the main entry point for the 
# aquaculture water quality checker application.

# Example usage:
reading = SensorReading.new(temperature: 28.0, ph: 8.0, dissolved_oxygen: 6.0)
checker = WaterQualityChecker.new(SalmonProfile.new)
alerts = checker.check(reading)

puts "ALERT: #{alerts.join(', ')}" if alerts.any?


# NOTE: Not removing the below code for now because,
# The following code is for testing against real scenarios. 
# We can uncomment it and run it with `sensor_test_data.json`.
# 
# require 'json'
# data = JSON.parse(File.read('../sensor_test_data.json'))
# checker = WaterQualityChecker.new(SalmonProfile.new)

# scenario = data['temperature_spike']

# scenario['readings'].each do |reading_data|
# reading = 
#   SensorReading.new(
#     temperature: reading_data['temperature'],
#     ph: reading_data['ph'],
#     dissolved_oxygen: reading_data['dissolved_oxygen'])
  
#   alerts = checker.check(reading)
#   if alerts.any?
#     puts "ALERT: #{alerts.join(', ')}"
#   end
# end
