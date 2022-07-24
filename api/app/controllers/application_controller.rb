# typed: strict
class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  # https://blog.furu07yu.com/entry/rails7-devise-token-auth#ActionDispatchRequestSessionDisabledSessionError%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6
  include DeviseHackFakeSession
end
