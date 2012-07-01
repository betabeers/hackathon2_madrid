pizza_offer = Offer.new
pizza_offer.title = "Betapizza"
pizza_offer.description = "Las mejores pizzas al mejor precio, y bien cocinadas!"
pizza_offer.save

pizza1 = pizza_offer.products.new
pizza1.title ="Pizza Margarita"
pizza1.description ="Los clásicos nunca mueren!"
pizza1.price = 5

pizza1.save

pizza2 = pizza_offer.products.new
pizza2.title ="Pizza Beta"
pizza2.description ="Versión a medio cocinar, para los gustosos de lo experimental"
pizza2.price = 6

pizza2.save

pizza3 = pizza_offer.products.new
pizza3.title ="Pizza Siete Quesos"
pizza3.description ="¿Cual es el queso favorito de Sherlock Holmes? El enmental, querido Watson"
pizza3.price = 7

pizza3.save
