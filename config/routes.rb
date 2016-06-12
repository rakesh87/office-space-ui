Rails.application.routes.draw do
  root 'home#index'
  get 'sign_in' => 'home#sign_in'
end
