# frozen_string_literal: true
# typed: false

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'Client', at: 'client_auth', controllers: {
        registrations: 'overrides/registrations'
      }
      mount_devise_token_auth_for 'OfficeRepresentative', at: 'office_representative_auth', controllers: {
        registrations: 'overrides/registrations'
      }
    end
  end

  # letter_opener_web
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  # ヘルスチェック
  get '/health_check', to: 'health_checks#index'
end
