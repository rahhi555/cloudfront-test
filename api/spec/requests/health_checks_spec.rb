require 'rails_helper'

RSpec.describe "HealthChecks", type: :request do
  describe "GET /health_checks" do
    it "response 200" do
      get health_check_path
      expect(response).to have_http_status(200)
    end
  end
end
