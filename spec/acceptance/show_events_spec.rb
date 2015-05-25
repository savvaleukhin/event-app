require_relative 'acceptance_helper'

feature 'Show list of events', '
  Only authenticated user be able to see list of events
' do
  given(:user) { create(:user) }
  given!(:events) { create_list(:event_list, 2, user: user) }

  scenario 'Authenticated user sees list of events' do
    sign_in user
    visit events_path

    expect(page).to have_content 'Events'
    expect(page).to have_content events[0].title
    expect(page).to have_content events[1].title
    expect(page).to have_content events[0].start_date
    expect(page).to have_content events[1].start_date
  end

  scenario 'Non-authenticated user visit root path' do
    visit root_path

    expect(page).to_not have_content 'Events'
    expect(page).to_not have_content events[0].title
    expect(page).to_not have_content events[1].title
    expect(page).to_not have_content events[0].start_date
    expect(page).to_not have_content events[1].start_date
    expect(page).to have_content 'Sample Event App'
  end
end
