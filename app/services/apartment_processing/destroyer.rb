class ApartmentProcessing::Destroyer < ServiceBase
  attr_reader :apartment

  def self.destroy!(apartment)
    new(apartment).destroy!
  end

  def initialize(apartment)
    super()
    @apartment = apartment
  end

  def destroy!
    @apartment.destroy!
  end
end
