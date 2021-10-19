class Filterer < ServiceBase
  attr_reader :params

  def self.filter!(params = nil)
    new(params).filter
  end

  def initialize(params)
    super()

    @params = params
  end

  def filter
    if @params['amenities']
      filter_by_amenities(@params['amenities'], Apartment.all)
    else
      @apartments = Apartment.filter(@params)
    end
  end

  private

  def filter_by_amenities(user_amenities, apartments)
    apartments.each do |apartment|
      apartment_amenities = apartment.amenities.pluck(:name)
      apartments = apartments.to_a - [apartment] if (apartment_amenities & user_amenities).empty?
    end
    apartments
  end
end
