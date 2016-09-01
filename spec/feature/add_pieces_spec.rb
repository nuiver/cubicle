require 'rails_helper'

feature 'User signup and signup processes', js: true do

  scenario 'login a user and add a piece' do
    member_role = Role.create(name: "Member", description: "Member that can trade")
    ella = User.create( email: 'ella@dress.com', password: 'abcd1234', role_id: member_role.id )
    p_ella = Profile.create( first_name: "Ella", surname: "Jansen", date_of_birth: "1986-08-09", addr_street: "Kerkweg", addr_number: "23", postcode: "8763AA", addr_town: "Floningen aan de Waas", phone: "0687541234", gender: 'female', size: "10", fav_color: "red", user: ella )

    visit root_path
    click_link('LOG IN')
    fill_in('Email', :with => 'ella@dress.com')
    fill_in('Password', :with => 'abcd1234')
    page.execute_script("$('form').submit()")

    click_link('add_piece')

    fill_in('piece_name', with: 'Dress name')
    fill_in('piece_brand', with: 'Brand name')
    attach_file('piece_image', './spec/feature/images/reddress2_f.jpg')
    attach_file('piece_image_b', './spec/feature/images/reddress2_b.jpg')
    select('6', :from => 'piece_size')
    select('black', :from => 'piece_colour')
    select('1', :from => 'piece_price_cat')

    page.execute_script("$('form').submit()")

    expect(page).to have_content('Dress name')
  end
end
