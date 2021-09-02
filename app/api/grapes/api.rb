module Grapes
  class API < Grape::API
    format :json
    prefix :api
    version 'v1', using: :path

    mount Grapes::V1::Apartments
  end
end
