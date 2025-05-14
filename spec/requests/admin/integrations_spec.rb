require 'rails_helper'

RSpec.describe "Admin::Integrations", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin/integrations/index"
      expect(response).to have_http_status(:success)
    end
  end

end
