require_relative "./order.rb"

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

  def run(io, order, time)
    while true do
      io.puts "Welcome! Please type a number to get started:\n1. View menu\n2. View your order\n3. Add an item to your order\n4. Place your order\n5. Close the program"

      user_input = io.gets.chomp

      case user_input
      
      when "1"
        io.puts display_menu
        
      when "2"
        io.puts view_order(order)
      
      when "3"
        io.puts "What would you like to add?"
        item = io.gets.chomp
        if @menu.key?(string_to_symbol(item))
          order.add_to_order(string_to_symbol(item))
          io.puts "Added #{item}"
        else
          io.puts "No such item, please try again (check spelling and capitalization)"
        end
      when "4"
        order.set_order_time(time)
        io.puts "Order placed at #{order.format_time(order.time_placed)}"
        break
      when "5"
        break
      else
        io.puts "Invalid number, please try again"
      end
    end
  end
  
  def string_to_symbol(string)
    string.downcase.split(" ").join("_").to_sym
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

# menu = InteractiveMenu.new
# order = Order.new
# menu.run(Kernel, order, Time.now)
