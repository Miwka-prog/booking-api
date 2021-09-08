class ApartmentAmenityProcessing::Destroyer < ServiceBase
  attr_reader :apartment_amenity

  def self.destroy!(apartment_amenity)
    new(apartment_amenity).destroy!
  end

  def initialize(apartment_amenity)
    super()
    @apartment_amenity = apartment_amenity
  end

  def destroy!
    @apartment_amenity.destroy!
  end
end
