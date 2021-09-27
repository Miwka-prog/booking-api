class BookingApartmentMailer < ApplicationMailer
  def show
    @recipient = params[:user]
    @room = params[:apartment]
    mail(to: @recipient.email, subject: 'Enjoy Your Trip! 🚗')
  end
end
