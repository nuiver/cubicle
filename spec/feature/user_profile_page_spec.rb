require 'rails_helper'

feature 'User profile page', js: true do

  scenario 'login a user and view profile' do
    member_role = Role.create(name: "Member", description: "Member that can trade")
    ella = User.create( email: 'ella@dress.com', password: 'abcd1234', role_id: member_role.id )
    p_ella = Profile.create( first_name: "Ella", surname: "Jansen", date_of_birth: "1986-08-09", addr_street: "Kerkweg", addr_number: "23", postcode: "8763AA", addr_town: "Floningen aan de Waas", phone: "0687541234", gender: 'female', size: "10", fav_color: "red", user: ella )

    visit root_path
    click_link('LOG IN')
    fill_in('Email', :with => 'ella@dress.com')
    fill_in('Password', :with => 'abcd1234')
    page.execute_script("$('form').submit()")

    click_link('user_name_link')

    expect(page).to have_content('Profile page of Ella')

  end
end
