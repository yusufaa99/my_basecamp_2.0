require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "GET /pricing" do
    it "returns http success" do
      get "/static_pages/pricing"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /about" do
    it "returns http success" do
      get "/static_pages/about"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /blog" do
    it "returns http success" do
      get "/static_pages/blog"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /contact" do
    it "returns http success" do
      get "/static_pages/contact"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /terms" do
    it "returns http success" do
      get "/static_pages/terms"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /search" do
    it "returns http success" do
      get "/static_pages/search"
      expect(response).to have_http_status(:success)
    end
  end

end
