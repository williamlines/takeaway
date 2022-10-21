  
class InteractiveMenu  
  def initialize
    @menu = {
      prawn_curry: 550,
      chilli_beef: 550,
      egg_fried_rice: 300,
      boiled_rice: 240,
      chicken_chow_mein: 430
    }
  end
  
  def format_symbol(symbol)
    symbol.to_s.capitalize.split("_").join(" ")
  end

  def format_price(price)
    pounds = (price / 100.0)
    pounds = sprintf('%.2f', pounds)
    return "£#{pounds}"
  end

  def display_menu
    menu_string = "Our menu:"
    @menu.each do |item, price|
      menu_string << "\n#{format_symbol(item)} -- #{format_price(price)}"
    end
    return menu_string
  end
  
  def view_order(order) 
    return "Order is empty: add something!" if order.order == {}
    
    order_string = "Your order:"
    grand_total = 0
    order.order.each do |item, quantity|
      grand_total += (@menu[item] * quantity)
      order_string <<"\n#{format_symbol(item)} x #{quantity} -- #{format_price(@menu[item] * quantity)}" 
    end
    return "#{order_string}\n******\nGrand total: #{format_price(grand_total)}"
    
  end
end