class ApartmentProcessing::Updater < ServiceBase
  attr_reader :apartment_id, :apartment_params

  def self.update!(apartment_id, apartment_params)
    new(apartment_id, apartment_params).update_apartment
  end

  def initialize(apartment_id, apartment_params)
    super()
    @apartment = apartment(apartment_id)
    @apartment_params = apartment_params
  end

  def update_apartment
    @apartment.update!(@apartment_params)
  end

  private

  def apartment(apartment_id)
    Apartment.find_by(id: apartment_id)
  end
end
