Piece.delete_all
Profile.delete_all
User.delete_all

ella = User.create( email: 'ella@dress.com', password: 'abcd1234' )
julia = User.create( email: 'julia@dress.com', password: 'abcd1234' )
stella = User.create( email: 'stella@dress.com', password: 'abcd1234' )

p_ella = Profile.create( first_name: "Ella", surname: "Jansen", date_of_birth: "1986-08-09", addr_street: "Kerkweg", addr_number: "23", postcode: "8763AA", addr_town: "Breda", phone: "0687541234", gender: 'female', size: "S", fav_color: "red", user: ella)
p_julia = Profile.create( first_name: "Julia", surname: "Bouwmeester", date_of_birth: "1977-04-24", addr_street: "Gen. Maczekstraat", addr_number: "88", postcode: "4444WS", addr_town: "Brabantdorp", phone: "0681542376", gender: 'female', size: "M", fav_color: "black", user: julia)
p_stella = Profile.create( first_name: "Stella", surname: "Valk", date_of_birth: "1992-01-19", addr_street: "Tulpenstraat", addr_number: "7", postcode: "2333AA", addr_town: "Akkerhoeven", phone: "0681753434", gender: 'female', size: "XS", fav_color: "black", user: stella)

piece1 = Piece.create( { name: "Skeeter Mini Dress", brand: "Twin Sister", image: open("http://images.asos-media.com/inv/media/5/2/8/3/7053825/black/image1xxl.jpg"), image_b: open("http://images.asos-media.com/inv/media/5/2/8/3/7053825/image2xxl.jpg"), size: "S", colour: "black", price_cat: 3, user: ella } )
piece2 = Piece.create( { name: "Long Sleeve Knit Dress", brand: "YAS", image: open("http://images.asos-media.com/inv/media/5/9/1/1/6791195/black/image1xxl.jpg"), image_b: open("http://images.asos-media.com/inv/media/5/9/1/1/6791195/image3xxl.jpg"), size: "XS", colour: "grey", price_cat: 4, user: stella } )
piece3 = Piece.create( { name: "V neck Dress", brand: "W.I.T.", image: open("http://images.asos-media.com/inv/media/5/4/9/2/6712945/black/image1xxl.jpg"), image_b: open("http://images.asos-media.com/inv/media/5/4/9/2/6712945/image2xxl.jpg"), size: "M", colour: "black", price_cat: 1, user: julia } )
piece4 = Piece.create( { name: "Ribbed Bodycon Mini Dress", brand: "New Look", image: open("http://images.asos-media.com/inv/media/1/5/0/8/6568051/image3xxl.jpg"), image_b: open("http://images.asos-media.com/inv/media/1/5/0/8/6568051/image2xxl.jpg"), size: "S", colour: "red", price_cat: 1, user: julia } )
