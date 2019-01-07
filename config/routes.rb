Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'clients#new'

  resources :clients, only: [:index, :new, :create, :edit, :update] do
    namespace :survey do
      resources :session_rating_scales, controller: 'sessions', type: 'Survey::SessionRatingScale'
      resources :children_session_rating_scales, controller: 'sessions', type: 'Survey::ChildrenSessionRatingScale'
    end
  end

  # Area displaying each therapists performance
  resources :reset_therapist_tokens, only: [:new, :create]
  resources :therapists, except: :show
  resources :therapists, only: :show, param: :token do
    resources :clients, only: :show, param: :token
  end
end
