class BookingApartmentProcessing::Creator < ServiceBase
  attr_reader :booking_apartment_params

  def self.create!(booking_apartment_params)
    new(booking_apartment_params).create_booking_apartment
  end

  def initialize(booking_apartment_params)
    super()

    @booking_apartment_params = booking_apartment_params
  end

  def create_booking_apartment
    BookingApartment.find_or_create_by(@booking_apartment_params)
  end
end
