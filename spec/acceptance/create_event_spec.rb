require_relative 'acceptance_helper'

feature 'User can create an event' do
  given(:user) { create(:user) }

  scenario 'Authenticated user creates an event' do
    sign_in user

    visit events_path
    click_on 'New'
    fill_in 'Title', with: 'My event'
    select Time.now.year, from: 'event_start_date_1i'
    select 'January', from: 'event_start_date_2i'
    select '1', from: 'event_start_date_3i'

    click_on 'Create Event'
    expect(current_path).to eq events_path
    expect(page).to have_content 'My event'
    expect(page).to have_content "#{Time.now.year}-01-01"
  end

  scenario 'User tries to create invalid event' do
    sign_in user

    visit events_path
    click_on 'New'
    click_on 'Create Event'

    expect(page).to have_content "Title can't be blank"
  end
end
