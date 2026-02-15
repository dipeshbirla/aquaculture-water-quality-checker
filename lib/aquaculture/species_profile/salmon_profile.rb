require_relative "base_profile"

# This class defines the specific thresholds for salmon.
class SalmonProfile < BaseProfile
  def thresholds
    # threshold requirement:
    # Salmon: Temperature 12-18°C, pH 6.5-8.5, Dissolved Oxygen > 7 mg/L
    
    {
      temperature: { min: 12, max: 18 },
      ph: { min: 6.5, max: 8.5 },
      dissolved_oxygen: { min: 7 }
    }
  end
end