require_relative 'acceptance_helper'

feature 'User can edit his profile' do
  given(:user) { create(:user) }


  scenario 'User changes name' do
    sign_in(user)

    click_on 'Edit profile'
    fill_in 'Name', with: 'New user name'
    fill_in 'Current password', with: '12345678'
    click_on 'Update'

    expect(page).to have_content 'Your account has been updated successfully.'
    expect(current_path).to eq root_path

    user.reload
    expect(user.name).to eq 'New user name'
  end

  scenario 'User changes email' do
    sign_in(user)

    click_on 'Edit profile'
    fill_in 'Email', with: 'new.user@test.com'
    fill_in 'Current password', with: '12345678'
    click_on 'Update'

    expect(page).to have_content 'Your account has been updated successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'User changes password' do
    sign_in(user)

    click_on 'Edit profile'
    fill_in 'Password', with: 'newpassword'
    fill_in 'Password confirmation', with: 'newpassword'
    fill_in 'Current password', with: '12345678'
    click_on 'Update'

    expect(page).to have_content 'Your account has been updated successfully.'
    expect(current_path).to eq root_path
  end
end
