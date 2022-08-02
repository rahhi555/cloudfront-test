# frozen_string_literal: true
# typed: true

class HealthChecksController < ApplicationController
  def index
    head :ok
  end
end
