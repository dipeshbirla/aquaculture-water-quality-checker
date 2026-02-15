require_relative "base_profile"

# This class defines the specific thresholds for tilapia.
class TilapiaProfile < BaseProfile
  def thresholds
    # threshold requirement:
    # Tilapia: Temperature 25-30°C, pH 6.5-9.0, Dissolved Oxygen > 5 mg/L
    
    {
      temperature: { min: 25, max: 30 },
      ph: { min: 6.5, max: 9.0 },
      dissolved_oxygen: { min: 5 }
    }
  end
end
