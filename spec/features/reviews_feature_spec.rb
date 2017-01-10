require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create name: 'Subway' }

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review Subway'
    fill_in "Thoughts", with: "too short"
    select '2', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to_eq '/restaurants'
    expect(page).to have_content 'too short'
  end
  
end
