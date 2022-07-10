# typed: true
class HealthChecksController < ApplicationController
  def index
    head :ok
  end
end
