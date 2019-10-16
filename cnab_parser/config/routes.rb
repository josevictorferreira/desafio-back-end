Rails.application.routes.draw do
  root to: 'home#index'

  post 'cnab_uploader/upload'
  get 'stores', to: 'store#index'
  get 'stores/:id', to: 'store#show', as: 'store'
end
