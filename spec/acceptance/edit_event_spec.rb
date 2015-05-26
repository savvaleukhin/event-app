require_relative 'acceptance_helper'

feature 'User can edit event' do
  given(:user) { create(:user) }
  given!(:event) { create(:event, user: user) }

  scenario 'Authenticated user edits an event' do
    sign_in user
    visit events_path

    click_on 'Edit'
    fill_in 'Title', with: 'Modified event'
    click_on 'Update Event'

    expect(page).to_not have_content event.title
    expect(page).to have_content 'Modified event'
    expect(current_path).to eq events_path
  end
end
