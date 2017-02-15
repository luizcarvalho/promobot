Rails.application.routes.draw do
  get 'admin/index'

  resources :promotions
  mount Facebook::Messenger::Server, at: 'bots'
end
