require 'spec_helper'

describe "ItemController" do

	describe "GET #items" do
		it "renders the :items view" do
			get '/items'
			last_response.should be_ok
		end
	end

end
