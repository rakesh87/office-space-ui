Rails.application.routes.draw do
  root 'home#index'
  get 'sign_in' => 'home#sign_in'
  post 'login' => 'home#login'
  get 'logout' => 'home#logout'
  get 'sign_up' => 'home#sign_up'
  post 'register' => 'home#register'
  post 'featured/:id' => 'home#mark_work_spce_featured'
end
