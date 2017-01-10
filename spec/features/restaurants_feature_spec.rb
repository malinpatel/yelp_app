require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurant have been added' do
    before do
      Restaurant.create(name: 'Subway')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('Subway')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, the displays the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Subway'
      click_button 'Create Restaurant'
      expect(page).to have_content 'Subway'
      expect(current_path).to eq '/restaurants'
    end

    context 'an invalid restaurant' do
      scenario 'does not let you submit a name that is too short' do
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end

  end

  context 'viewing restaurants' do
    let!(:subway){ Restaurant.create(name: 'Subway') }

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'Subway'
      expect(page).to have_content 'Subway'
      expect(current_path).to eq "/restaurants/#{subway.id}"
    end
  end

  context 'editing restaurants' do
    before { Restaurant.create name: 'Subway', description: 'foot long is best' }

    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit Subway'
      fill_in 'Name', with: 'KFC'
      fill_in "Description", with: 'quite a change really'
      click_button 'Update Restaurant'
      expect(page).to have_content 'KFC'
      expect(page).to have_content 'quite a change really'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do
    before { Restaurant.create name: 'Nandos', description: "Finger lickin' chicken" }

    scenario 'removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      click_link 'Delete Nandos'
      expect(page).not_to have_content 'Nandos'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

end
