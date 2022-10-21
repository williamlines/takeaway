  
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
  
  def view_order 
    "Order is empty: add something!"
  end
end