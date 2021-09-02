Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               registrations: 'registrations',
               sessions: 'sessions'
             }
  mount Grapes::API => '/'
end
