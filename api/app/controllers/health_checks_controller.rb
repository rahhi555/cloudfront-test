# typed: false
class HealthChecksController < ApplicationController
  def index
    head :ok
  end
end
