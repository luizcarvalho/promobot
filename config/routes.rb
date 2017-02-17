Rails.application.routes.draw do
  post 'api/responder'

  get 'admin/index'

  resources :promotions
  mount Facebook::Messenger::Server, at: 'bots'
end
