require 'spec_helper'
require 'rails_helper'

feature 'the signup process', type: :feature do
    before(:each) do 
        create(:user) 
    end    
    scenario 'has a new user page' do 
        visit new_user_url 
        expect(page).to have_content('Sign-Up')
    end

    feature 'signing up a user' do
        scenario 'shows username on the homepage after signup' do 
            visit new_user_url
            fill_in('username', with: "#{user.username}")
            fill_in('password', with: "fruitypebbles")
            click_button('Sign Up!')
        end 

    end
end

feature 'logging in' do
    scenario 'shows username on the homepage after login'
end

feature 'logging out' do
    scenario 'begins with a logged out state'

    scenario 'doesn\'t show username on the homepage after logout'

end