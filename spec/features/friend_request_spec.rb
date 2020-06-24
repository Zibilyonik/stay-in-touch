require 'spec_helper'

RSpec.describe 'User Friends', type: :feature do
  before :each do
    @user1 = User.create(email: 'test1@test.com', name: 'Potato', password: 'lalala')
    @user2 = User.create(email: 'test2@test.com', name: 'Potato', password: 'lalala')
    @user1.save!
    @user2.save!
    visit '/users/sign_in'
    fill_in 'Email', with: @user1.email
    fill_in 'Password', with: @user1.password
    click_button 'Log in'
  end

  after :each do
    @user1.destroy!
    @user2.destroy!
  end

  it 'creates new request' do
    visit '/users/2'
    click_on 'Add Friend'
    visit user_path(@user1.id)
    expect(page).to have_content @user2.name
  end

  it 'cancels request' do
    visit user_path(@user2.id)
    click_on 'Add Friend'
    visit user_path(@user2.id)
    expect(page).to have_button 'Cancel'
  end
end
