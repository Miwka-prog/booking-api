class Filterer < ServiceBase
  attr_reader :params

  def self.filter!(params = nil)
    new(params).filter
  end

  def initialize(params)
    super()

    @params = params
  end

  def filter # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/AbcSize
    apartments = Apartment.all
    apartments = filter_by_amenities(@params['amenities'], apartments) if @params['amenities']
    apartments = apartments.sorted_by(@params['sorted_type']) if @params['sorted_type']
    apartments = apartments.filter_by_type(@params['apartment_type']) if @params['apartment_type']
    if @params['rooms_and_beds']
      if @params['rooms_and_beds']['beds']
        apartments = apartments.filter_by_rooms_and_beds('beds', @params['rooms_and_beds']['beds'])
      end
      if @params['rooms_and_beds']['bedrooms']
        apartments = apartments.filter_by_rooms_and_beds('bedrooms', @params['rooms_and_beds']['bedrooms'])
      end
      if @params['rooms_and_beds']['bathrooms']
        apartments = apartments.filter_by_rooms_and_beds('bathrooms', @params['rooms_and_beds']['bathrooms'])
      end
    end
    apartments
  end

  private

  def filter_by_amenities(user_amenities, apartments)
    apartments.each do |apartment|
      apartment_amenities = apartment.amenities.pluck(:name)
      apartments.destroy(apartment.id) if (apartment_amenities & user_amenities).empty?
    end
    Apartment.all
  end
end
