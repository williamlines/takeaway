class Order
  def initialize
    @order = {}
    @time_placed = 0
  end
  
  def order
    return @order
  end

  def time_placed
    return @time_placed
  end

  def add_to_order(item)
    if @order.key?(item)
      @order[item] += 1
    else
      @order[item] = 1
    end
  end
end