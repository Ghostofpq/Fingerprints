require 'spec_helper'

describe UserController do

  describe "GET 'stats'" do
    it "returns http success" do
      get 'stats'
      response.should be_success
    end
  end

end
