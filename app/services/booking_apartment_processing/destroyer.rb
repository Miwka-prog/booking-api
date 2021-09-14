class BookingApartmentProcessing::Destroyer < ServiceBase
  attr_reader :booking_apartment

  def self.destroy!(booking_apartment)
    new(booking_apartment).destroy!
  end

  def initialize(booking_apartment)
    super()
    @booking_apartment = booking_apartment
  end

  def destroy!
    @booking_apartment.destroy!
  end
end
