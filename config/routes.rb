Rails.application.routes.draw do
  get '/posts', to: 'posts#index'

  root 'posts#index'
end
