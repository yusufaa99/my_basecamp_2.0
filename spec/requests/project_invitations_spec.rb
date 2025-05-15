require 'rails_helper'

RSpec.describe "ProjectInvitations", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/project_invitations/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/project_invitations/create"
      expect(response).to have_http_status(:success)
    end
  end

end
