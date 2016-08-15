Piece.delete_all
User.delete_all

ella = User.create( email: 'ella@dress.com', password: 'abcd1234' )
julia = User.create( email: 'julia@dress.com', password: 'abcd1234' )
stella = User.create( email: 'stella@dress.com', password: 'abcd1234' )

piece1 = Piece.create( { name: "Short Sleeve Mini Dress", brand: "Twin Sister", image: "http://images.asos-media.com/inv/media/7/2/4/7/5907427/teal/image1xxl.jpg", image_b: "http://images.asos-media.com/inv/media/7/2/4/7/5907427/image2xxl.jpg", size: "M", colour: "teal", price_cat: 3, user: ella } )
piece2 = Piece.create( { name: "Lurex Dress", brand: "Oasis", image: "http://images.asos-media.com/inv/media/3/9/9/6/6006993/silverandblack/image1xxl.jpg", image_b: "http://images.asos-media.com/inv/media/3/9/9/6/6006993/image2xxl.jpg", size: "S", colour: "silver", price_cat: 2, user: ella } )
piece3 = Piece.create( { name: "Rib Jumper Dress", brand: "W.I.T.", image: "http://images.asos-media.com/inv/media/9/1/0/1/5261019/burntginger/image1xxl.jpg", image_b: "http://images.asos-media.com/inv/media/9/1/0/1/5261019/image2xxl.jpg", size: "M", colour: "brown", price_cat: 1, user: julia } )
