require 'rails_helper'

feature 'reviewing' do

  scenario 'allows users to leave a review using a form' do
    sign_up
    create_restaurant
    click_link 'Review Subway'
    fill_in "Thoughts", with: "too short"
    select '2', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content 'too short'
  end

  scenario 'allows users to only leave one review' do
    sign_up
    create_restaurant
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

  scenario 'allows users to delete their review' do
    sign_up
    create_restaurant
    leave_review
    click_link 'Delete Subway review'
    expect(page).to_not have_content('Amazing')
  end
end
