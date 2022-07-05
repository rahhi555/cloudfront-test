# typed: false
Rails.application.routes.draw do
  # ヘルスチェック
  get '/health_check', to: 'health_checks#index'

  resources :blogs, only: %i[index show create]
end
