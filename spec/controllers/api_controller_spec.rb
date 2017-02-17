require 'rails_helper'

RSpec.describe ApiController, type: :controller do

  describe "GET #responder" do
    it "returns http success" do
      get :responder
      expect(response).to have_http_status(:success)
    end
  end

end
