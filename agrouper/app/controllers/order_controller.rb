class OrderController < ApplicationController
  def new
  	offer_id = params[:id]
  	offer = Offer.find(offer_id)

  	order = offer.orders.new
  	order.save
  	redirect_to :action => :control, :id => order.id
  end

  def join
  	order_id = params[:id]
  	@order = Order.find(order_id)
  	if params[:user]
  		user = @order.users.where({:username => params[:user][:username]}).first
  		if user == nil
			user = @order.users.new
  			user.username = params[:user][:username]
  		end
  		user.save
  		session[:user_id] = user.id
  		redirect_to :action => :choose, :id => @order.id
  	else
  		order_id = params[:id]
  		@order = Order.find(order_id)
  	end
  end

  def control
  	order_id = params[:id]
  	@order = Order.find(order_id)
  end

  def ban_user
  	order_id = params[:orderid]
  	user_id = params[:userid]
  	@user = User.find(user_id)
  	@user.delete

  	redirect_to :action => :control, :id => order_id


  end


  def invite
    InviteMailer.invite_email(params[:mail],params[:id]).deliver
    render :text => ""
  end

  def choose
	order_id = params[:id]
	@order = Order.find(order_id)
  begin
	 @user = User.find(session[:user_id])
  rescue
    params[:id] = nil
    return redirect_to '/'
  end

  if @order.closed == true
    return render:template => "order/pay_paypal", :layout => false
  end
  
    if params["ajax"] == "1"
      return render :layout => false
    else
      render
    end
  end


  def checkout
    order_id = params[:id]
    @order = Order.find(order_id)
    @order.closed = true
    @order.save
  end

  def add
	order_id = params[:id]
	user_id = session[:user_id]
	product_id = params[:product_id]
	quantity = params[:quantity]

	order = Order.find(order_id)
	user = order.users.find(user_id)

	product = order.offer.products.find(product_id)

	item = user.items.where(:product_id => product_id).first
	if item == nil
		item = user.items.new
		item.quantity = 1
		item.product = product
	else
		item.quantity += quantity.to_i
	end

	if item.quantity == 0
		item.delete
	else
		item.save
		item.product.save
	end

  	redirect_to :action => :choose, :id => order.id
  end

  def updated_list
    order_id = params[:id]
    @order = Order.find(order_id)
    render :layout => false
  end

  def updated_price
    order_id = params[:id]
    @order = Order.find(order_id)
    price = @order.get_total
    percentage = @order.calculate_order_discount*100 / @order.offer.get_discounts.last[:percentage] 
    render :text => ( price.to_s + "/" + percentage.to_s )
  end

  def next_discount
    order_id = params[:id]
    @order = Order.find(order_id)
    render :layout => false
  end

end
