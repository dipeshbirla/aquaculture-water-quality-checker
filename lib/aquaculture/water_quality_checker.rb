# This class is responsible for checking water quality readings against the thresholds 
# defined in a species profile.
class WaterQualityChecker
  # Define units for each parameter to use in alert messages
  UNITS = {
    temperature: '°C',
    ph: '',
    dissolved_oxygen: ' mg/L'
  }.freeze

  def initialize(species_profile)
    @profile = species_profile
  end
  
  def check(reading)
    alerts = []

    @profile.thresholds.each do |type, limits|
      # Use public_send to dynamically access the reading's attributes 
      # based on the type of threshold we're checking
      value = reading.public_send(type)
      unit  = UNITS[type]
      min_limit, max_limit = limits[:min], limits[:max]

      if min_limit && value < min_limit
        alerts << low_alert(type, value, min_limit, unit)
      end

      if max_limit && value > max_limit
        alerts << high_alert(type, value, max_limit, unit)
      end
    end

    alerts
  end

  private
 
  # Helper methods to generate alert messages
  # Using metaprogramming to avoid repetition in low/high alert generation

  # Methods: low_alert and high_alert
  %i[low high].each do |direction|
  define_method("#{direction}_alert") do |type, value, limit, unit|
    bound = direction == :low ? 'min' : 'max'

    "#{label(type)} too #{direction}: #{value}#{unit} (#{bound}: #{limit}#{unit})"
  end
end

  def label(type)
    type == :ph ? 'pH' : capitalize(type.to_s)
  end

  def capitalize(type)
    type.tr("_", " ").capitalize
  end
end
