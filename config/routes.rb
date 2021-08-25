Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               registrations: 'registrations',
               sessions: 'sessions'
             }
  resources :ping, only: [:index] do
    collection do
      get :auth
    end
  end
end
