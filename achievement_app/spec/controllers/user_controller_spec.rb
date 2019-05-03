require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    describe 'GET #new' do 
        it 'brings up form to sign up' do
            get :new
            expect(response).to render_template(:new)
        end
    end

    describe 'POST #create' do
        before(:each) do
            create(:user)
            # allow(subject).to_receive(:current_user).and_return(User.last)
        end

        let(:valid_params) {{user:{username:"midnightowl", password:"fruitypebbles"}}}
        let(:invalid_password_params) {{user:{username:"middayowl", password: "fruity"}}}

        context "with valid params" do
            it "should create the user" do
                post :create, params: valid_params 
                expect(User.last.username).to eq("midnightowl")
                expect(User.last.is_password?("fruitypebbles")).to be(true) 
            end 

            it "should redirect to all goals page by user"
        end

        context "with invalid params" do
            before(:each) do 
                post :create, params: invalid_password_params
            end
            it "should not create the user" do 
                # post :create, params: invalid_password_params 
                expect(User.find_by(username: "middayowl")).to be(nil)
            end

            it "should redirect to sign up page" do
                expect(response).to render_template(:new)
            end

            it "should show an error" do
                expect(flash[:errors]).to be_present
            end
        end 
    end

end
