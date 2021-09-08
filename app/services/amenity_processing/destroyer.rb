class AmenityProcessing::Destroyer < ServiceBase
  attr_reader :amenity

  def self.destroy!(amenity)
    new(amenity).destroy!
  end

  def initialize(amenity)
    super()
    @amenity = amenity
  end

  def destroy!
    @amenity.destroy!
  end
end
