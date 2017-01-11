require 'rails_helper'

feature 'reviewing' do
  before do
    user = User.create(email: "test@test.com", password: "testtest")
    user.restaurants.create(name: "Subway")
  end

  scenario 'allows users to leave a review using a form' do
    sign_up
    visit '/restaurants'
    click_link 'Review Subway'
    fill_in "Thoughts", with: "too short"
    select '2', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'too short'
  end

  scenario 'allows users to only leave one review' do
    sign_up
    visit '/restaurants'
    click_link 'Review Subway'
    fill_in "Thoughts", with: "too short"
    select '2', from: 'Rating'
    click_button 'Leave Review'
    click_link 'Review Subway'
    fill_in "Thoughts", with: "too short"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(page).to have_content 'You have already reviewed this restaurant'
  end

end
