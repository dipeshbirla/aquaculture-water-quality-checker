# This is the base profile class that other species profiles will inherit from.
# It defines the interface for the thresholds method, which must be implemented by each specific species profile.
class BaseProfile
  def thresholds
    raise NotImplementedError, "#{self.class} must implement #thresholds"
  end
end
