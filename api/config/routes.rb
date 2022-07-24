# typed: false
Rails.application.routes.draw do
  # devise_token_auth: https://devise-token-auth.gitbook.io/devise-token-auth/usage/overrides
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'overrides/registrations'
  }

  # letter_opener_web
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  # ヘルスチェック
  get '/health_check', to: 'health_checks#index'

  resources :blogs, only: %i[index show create]
end
