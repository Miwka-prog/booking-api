class ApartmentProcessing::Creator < ServiceBase
  attr_reader :apartment_params

  def self.create!(apartment_params)
    new(apartment_params).create_apartment
  end

  def initialize(apartment_params)
    super()

    @apartment_params = apartment_params
  end

  def create_apartment
    Apartment.find_or_create_by(@apartment_params)
  end

  def current_user
    User.find_by(id: @apartment_params['user_id'])
  end
end
