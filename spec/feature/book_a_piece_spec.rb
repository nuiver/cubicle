require 'rails_helper'

feature 'Book a piece', js: true do

  scenario 'click a piece for Pieces/index' do
    member_role = Role.create(name: "Member", description: "Member that can trade")
    ella = User.create( email: 'ella@dress.com', password: 'abcd1234', role_id: member_role.id )
    p_ella = Profile.create( first_name: "Ella", surname: "Jansen", date_of_birth: "1986-08-09", addr_street: "Kerkweg", addr_number: "23", postcode: "8763AA", addr_town: "Floningen aan de Waas", phone: "0687541234", gender: 'female', size: "10", fav_color: "red", user: ella )


    miep = User.create( email: 'miep@dress.com', password: 'abcd1234', role_id: member_role.id )
    p_miep = Profile.create( first_name: "Miep", surname: "Klaasen", date_of_birth: "1986-08-09", addr_street: "Kerkweg", addr_number: "23", postcode: "8763AA", addr_town: "Floningen aan de Waas", phone: "0687541234", gender: 'female', size: "10", fav_color: "red", user: miep )

    piece1 = Piece.create( { name: "Mini Dress", brand: "Twin Sister", product_type: "dress", image: open('./spec/feature/images/reddress2_f.jpg'), image_b: open('./spec/feature/images/reddress2_f.jpg'), size: "10", colour: "black", price_cat: 3, user: ella, begin_date: "2016-01-01", end_date: "2032-01-01" } )

    visit root_path
    click_link('LOG IN')
    fill_in('Email', :with => 'miep@dress.com')
    fill_in('Password', :with => 'abcd1234')
    page.execute_script("$('form').submit()")


    expect(page).to have_content('Mini Dress')
  end

  scenario 'click the book link in Pieces/show' do
    member_role = Role.create(name: "Member", description: "Member that can trade")
    ella = User.create( email: 'ella@dress.com', password: 'abcd1234', role_id: member_role.id )
    p_ella = Profile.create( first_name: "Ella", surname: "Jansen", date_of_birth: "1986-08-09", addr_street: "Kerkweg", addr_number: "23", postcode: "8763AA", addr_town: "Floningen aan de Waas", phone: "0687541234", gender: 'female', size: "10", fav_color: "red", user: ella )


    miep = User.create( email: 'miep@dress.com', password: 'abcd1234', role_id: member_role.id )
    p_miep = Profile.create( first_name: "Miep", surname: "Klaasen", date_of_birth: "1986-08-09", addr_street: "Kerkweg", addr_number: "23", postcode: "8763AA", addr_town: "Floningen aan de Waas", phone: "0687541234", gender: 'female', size: "10", fav_color: "red", user: miep )

    piece1 = Piece.create( { name: "Mini Dress", brand: "Twin Sister", product_type: "dress", image: open('./spec/feature/images/reddress2_f.jpg'), image_b: open('./spec/feature/images/reddress2_f.jpg'), size: "10", colour: "black", price_cat: 3, user: ella, begin_date: "2016-01-01", end_date: "2032-01-01" } )

    visit root_path
    click_link('LOG IN')
    fill_in('Email', :with => 'miep@dress.com')
    fill_in('Password', :with => 'abcd1234')
    page.execute_script("$('form').submit()")

    click_link('Mini Dress')

    click_link('book-button')

    expect(page).to have_content('Book this item')
  end
end
