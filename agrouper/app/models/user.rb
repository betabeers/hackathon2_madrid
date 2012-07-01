class User
  include Mongoid::Document

  belongs_to :order
  has_many :items

  field :username
 
  def get_total
  	self.items.to_a.sum {|u| u.get_total }
  end

  def get_count
  	self.items.to_a.sum {|u| u.quantity }
  end
 end
