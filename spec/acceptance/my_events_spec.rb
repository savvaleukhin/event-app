require_relative 'acceptance_helper'

feature 'Show only my events', '
  Authenticated user be able to filter list events to see only his events
' do
  given(:user) { create(:user) }
  given!(:events) { create_list(:event_list, 2, user: user) }
  given!(:other_event) { create(:event_with_user) }

  scenario 'Authenticated user sees list of events' do
    sign_in user
    visit events_path

    expect(page).to have_content events[0].title
    expect(page).to have_content events[1].title
    expect(page).to have_content other_event.title

    click_on 'My events'

    expect(page).to have_content 'Events'
    expect(page).to have_content events[0].title
    expect(page).to have_content events[1].title
    expect(page).to_not have_content other_event.title
  end
end
