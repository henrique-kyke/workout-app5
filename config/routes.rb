Rails.application.routes.draw do
  devise_for :users do
    resources :exercise
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "dashboards#index"
end
