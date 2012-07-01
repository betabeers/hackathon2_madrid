class Item
  include Mongoid::Document
  belongs_to :product

  field :quantity, type: Integer

  belongs_to :user
  def get_total
  	self.product.price * self.quantity
  end

end