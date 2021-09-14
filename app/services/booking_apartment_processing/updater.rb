class BookingApartmentProcessing::Updater < ServiceBase
  attr_reader :booking_apartment_id, :booking_params

  def self.update!(booking_apartment_id, booking_params)
    new(booking_apartment_id, booking_params).update_booking_apartment
  end

  def initialize(booking_apartment_id, booking_params)
    super()
    @booking_apartment = booking_apartment(booking_apartment_id)
    @booking_params = booking_params
  end

  def update_booking_apartment
    @booking_apartment.update!(@booking_params)
  end

  private

  def booking_apartment(booking_apartment_id)
    BookingApartment.find_by(id: booking_apartment_id)
  end
end
