
class Order
  def initialize
    @order = {}
    @time_placed = 0
  end
  
  def add_to_order(item)
    if @order.key?(item)
      @order[item] += 1
    else
      @order[item] = 1
    end
  end
  
  def order
    return @order
  end

  def view_order 
    # displays order with dishes, quantity and total price
  end

  def time_placed
    return @time_placed
  end

  def set_order_time
    # updates @time_placed to current time
  end

  def delivery_time
    # calculates est. time to delivery
  end

  def confirmation_text
    # sends confirmation text with delivery time
  end

  def format_symbol(symbol)
    symbol.to_s.capitalize.split("_").join(" ")
  end

  def format_price(price)
    
  end
  
  def format_time
    # formats current @time_placed to readable format e.g 2022-10-20 16:16:53.303608 +0100 => 16:16
  end
end