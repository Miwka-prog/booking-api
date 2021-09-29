module Booking
  module V1
    class Users < Booking::API
      # rename file
      helpers ::APIHelpers::AuthenticationHelper
      before { authenticate! }
      desc 'Add card'
      params do
        requires :number, type: Integer
        requires :exp_month, type: Integer
        requires :exp_year, type: Integer
        requires :exp_year, type: Integer
        requires :cvc, type: Integer
      end
      post 'add_card' do
        token = Stripe::Token.create({
                                       card: {
                                         number: params['number'],
                                         exp_month: params['exp_month'],
                                         exp_year: params['exp_year'],
                                         cvc: params['cvc']
                                       }
                                     })
        Stripe::Customer.create_source(
          current_user.stripe_id.to_s,
          { source: token.id }
        )
      end
    end
  end
end
