class Offer
  include Mongoid::Document
  field :title, type: String
  field :text, type: String
  field :description, type: String

  has_many :products
  has_many :orders

  def get_discounts
  	[{:users_required => 2, :percentage => 0.1, :lower_limit => 20},
  	{:users_required => 4, :percentage => 0.2, :lower_limit => 50},
  	{:users_required => 8, :percentage => 0.3, :lower_limit => 75}]
  end
end