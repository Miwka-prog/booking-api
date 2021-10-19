module Booking
  module V2
    class Users < Booking::API
      helpers ::APIHelpers::AuthenticationHelper
      helpers do
        def create_token
            Stripe::Token.create({
                                                   card: {
                                                     number: params['number'],
                                                     exp_month: params['exp_month'],
                                                     exp_year: params['exp_year'],
                                                     cvc: params['cvc']
                                                   }
                                                 })
        end
      end
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
        token = create_token
        source = Stripe::Customer.create_source(
          current_user.stripe_id.to_s,
          { source: token.id }
        )
        AddingCardPolicy.new(current_user, source).create?
        source
      end
    end
  end
end
