module APIHelpers
  module ExceptionHelper
    def not_found
      error!('Record Not Found', 404)
    end
  end
end
