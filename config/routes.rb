Rails.application.routes.draw do
  get '/posts/index', to: 'posts#index'

  root 'posts#index'
end
