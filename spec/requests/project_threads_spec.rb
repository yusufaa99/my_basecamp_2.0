require 'rails_helper'

RSpec.describe "ProjectThreads", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/project_threads/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/project_threads/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/project_threads/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/project_threads/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/project_threads/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
