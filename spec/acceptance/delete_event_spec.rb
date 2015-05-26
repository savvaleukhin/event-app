require_relative 'acceptance_helper'

feature 'User can delete event' do
  given(:user) { create(:user) }
  given!(:event) { create(:event, user: user) }

  scenario 'User can delete requested event' do
    sign_in user
    visit events_path

    click_on 'Delete'
    expect(page).to_not have_content 'MyString'
  end
end
