class Order
  include Mongoid::Document
  field :qrcode, type: String
  field :closed, type: Boolean
  belongs_to :offer
  has_many :users

  def get_total
  	self.users.to_a.sum {|u| u.get_total }
  end

  def get_persons_with_order
  	self.users.to_a.sum do |u| 
  		if u.get_count > 0
  			1
  		else
  			0
  	 	end 
  	end
  end


  def calculate_order_discount
  	discounts = self.offer.get_discounts
  	people_count = get_persons_with_order
  	order_total = get_total

  	discount = 0

  	discounts.each do |disc|
  		if disc[:users_required] <= people_count && disc[:lower_limit] <= order_total
  			discount = disc[:percentage]
  		end
  	end
  	discount
  end


  def get_next_discount
  	discounts = self.offer.get_discounts
  	people_count = get_persons_with_order
  	order_total = get_total

  	discount = 0
  	i = -1
  	discounts.each_with_index do |disc,idx|
  		if disc[:users_required] <= people_count && disc[:lower_limit] <= order_total
  			i = idx
  		end
  	end
  	if i == discounts.length - 1
  		return {:next => :max, :total => discounts.length, :current => discounts.length}
  	else
  		return {:next => discounts[i+1], :total => discounts.length, :current => i,
  			:remaining_people => discounts[i+1][:users_required] - people_count,
  			:remaining_money => discounts[i+1][:lower_limit] - order_total,
  			:next_percent => discounts[i+1][:percentage]
  		}
  	end
  end
end
