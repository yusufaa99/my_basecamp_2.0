require 'rails_helper'

RSpec.describe "Invitations", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/invitations/index"
      expect(response).to have_http_status(:success)
    end
  end

end
