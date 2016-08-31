require 'rails_helper'

feature 'User signup and signup processes', js: true do

  scenario 'signup a user, logout and login' do
    visit new_user_registration_path

    fill_in('Email', :with => 'esther@dress.com')
    fill_in('Password', :with => 'abcd1234')
    fill_in('Password confirmation', :with => 'abcd1234')
    fill_in('First name', :with => 'Esther')
    fill_in('Surname', :with => 'Jansen')
    fill_in('user_profile_attributes_addr_street', :with => 'Straatweg')
    fill_in('user_profile_attributes_addr_number', :with => '12B')
    fill_in('user_profile_attributes_postcode', :with => 'esther@dress.com')
    fill_in('user_profile_attributes_addr_town', :with => 'esther@dress.com')
    fill_in('user_profile_attributes_phone', :with => '0123456789')
    select('female', :from => 'user_profile_attributes_gender')
    fill_in('user_profile_attributes_date_of_birth', :with => '01-01-1977')
    select('red', :from => 'user_profile_attributes_fav_color')
    select('10', :from => 'user_profile_attributes_size')

    page.execute_script("$('form').submit()")

    expect(page).to have_content('ESTHER JANSEN')

    puts "User signup succesfull"

    click_link('LOG OUT')

    puts "User logout succesfull"

    click_link('LOG IN')
    fill_in('Email', :with => 'esther@dress.com')
    fill_in('Password', :with => 'abcd1234')
    page.execute_script("$('form').submit()")

    expect(page).to have_content('ESTHER JANSEN')

    puts "User login succesfull"

  end

end
