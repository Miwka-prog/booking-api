class ApartmentAmenityProcessing::Creator < ServiceBase
  attr_reader :apartment_amenity_params

  def self.create!(apartment_amenity_params)
    new(apartment_amenity_params).create_apartment_amenity
  end

  def initialize(apartment_amenity_params)
    super()

    @apartment_amenity_params = apartment_amenity_params
  end

  def create_apartment_amenity
    ApartmentAmenity.find_or_create_by(@apartment_amenity_params)
  end
end
