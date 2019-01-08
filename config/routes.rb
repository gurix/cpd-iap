Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'clients#new'

  resources :clients, only: [:index, :new, :create, :edit, :update] do
    namespace :survey do
      resources :session_rating_scales, controller: 'sessions', type: 'Survey::SessionRatingScale'
    end
  end

  # Area displaying each counselors performance
  resources :reset_counselor_tokens, only: [:new, :create]
  resources :counselors, except: :show
  resources :counselors, only: :show, param: :token do
    resources :clients, only: :show, param: :token
  end
end
