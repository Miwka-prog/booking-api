# Preview all emails at http://localhost:3000/rails/mailers/booking_apartment
class BookingApartmentPreview < ActionMailer::Preview
  def show
    BookingApartmentMailer.with(user: User.first, apartment: Apartment.first).show
  end
end
