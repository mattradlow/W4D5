# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(7) }

  describe 'uniqueness' do 
    before(:each) do 
      create(:user) 
    end 

    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:session_token) }
  end 

  describe '#reset_session_token!' do 
    let!(:user) { create(:user) }
    it 'should change the session token' do 
      current_session_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).to_not eq(current_session_token)
    end 
  end 

  describe "#password=" do
    let!(:user) { create(:user) }
    it 'should not set the password_digest to be the password' do
      expect(user.password_digest).to_not eq('fruitypebbles')
    end
end

  describe '#is_password?' do 
    let!(:user) { create(:user) }
    context 'with valid password' do 
      it 'should return true' do 
      expect(user.is_password?('fruitypebbles')).to be(true) 
    end 
  end 

    context 'with invalid password' do 
      it 'should return false' do 
        expect(user.is_password?('cocoapebbles')).to be(false)
      end 
    end 
  end 

  describe "::find_by_credentials" do
    let!(:user) {create(:user)}
    
    context "with valid username and password" do
      # allow(:user).to_receive(:username).and_return()
      it "should return the user with the correct username and password" do
        expect(User.find_by_credentials(user.username, 'fruitypebbles')).to eq(user)
      end
    end

    context "with invalid password" do
      it "should return nil with invalid password" do
        expect(User.find_by_credentials(user.username, 'cocoapedbbles')).to be(nil)
      end
    end

    context "with invalid username" do
      it "should return nil with invalid username" do
        expect(User.find_by_credentials('weridname', 'fruitypebbles')).to be(nil)
      end
    end
  end
end
