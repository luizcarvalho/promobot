Rails.application.routes.draw do
  resources :promotions
  Rails.application.routes.draw do
    mount Facebook::Messenger::Server, at: 'bots'
  end
end
