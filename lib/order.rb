
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

  def time_placed
    return @time_placed
  end

  def set_order_time(time)
    @time_placed = time
  end

  def delivery_time
    format_time(time_placed + 30*60)
  end

  def confirmation_text
    # sends confirmation text with delivery time
  end

  def format_symbol(symbol)
    symbol.to_s.capitalize.split("_").join(" ")
  end

  def format_price(price) # price is integer in pence
    pounds = (price / 100.0)
    pounds = sprintf('%.2f', pounds)
    return "£#{pounds}"
  end
  
  def format_time(time)
    time.to_s.split(" ")[1].split(":").first(2).join(":")
  end
end