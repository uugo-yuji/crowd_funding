require 'rails_helper'

RSpec.describe "Administer::Investments", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/administer/investment/index"
      expect(response).to have_http_status(:success)
    end
  end

end
