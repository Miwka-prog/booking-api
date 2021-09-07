class AmenityProcessing::Creator < ServiceBase
  attr_reader :amenity_params

  def self.create!(amenity_params)
    new(amenity_params).create_apartment
  end

  def initialize(amenity_params)
    super()

    @amenity_params = amenity_params
  end

  def create_apartment
    Amenity.find_or_create_by(@amenity_params)
  end
end
