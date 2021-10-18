class Searcher < ServiceBase
  attr_reader :params

  def self.search!(params = nil)
    new(params).search
  end

  def initialize(params)
    super()

    @params = params
  end

  def search
    @apartments = Apartment.filter_by_city(@params['city'])
    @apartments.each do |apartment|
      not_available = not_available(apartment)
      @apartments = @apartments.to_a - [apartment] if not_available.size.positive?
    end
    @apartments
  end

  def not_available(apartment)
    start_date = @params['start_date']
    end_date = @params['end_date']
    apartment.booking_apartment.where(
      "((? <= start_date AND start_date <= ?)
          OR (? <= end_date AND end_date <= ?)
          OR (start_date < ? AND ? < end_date))",
      start_date, end_date,
      start_date, end_date,
      start_date, end_date
    ).limit(1)
  end
end
