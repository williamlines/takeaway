require "interactive_menu"

RSpec.describe InteractiveMenu do
  it "can display the menu" do
    menu = InteractiveMenu.new
    expect(menu.display_menu).to eq("Our menu:\nPrawn curry -- £5.50\nChilli beef -- £5.50\nEgg fried rice -- £3.00\nBoiled rice -- £2.40\nChicken chow mein -- £4.30")
  end
  context "testing formatters" do
    it "testing symbol formatter" do
      menu = InteractiveMenu.new
      expect(menu.format_symbol(:prawn_curry)).to eq "Prawn curry"
      expect(menu.format_symbol(:this_symbol_is_way_longer_than_usual)).to eq "This symbol is way longer than usual"
    end
    it "testing price formatter" do
      menu = InteractiveMenu.new
      expect(menu.format_price(100)).to eq "£1.00"
      expect(menu.format_price(550)).to eq "£5.50"
      expect(menu.format_price(123)).to eq "£1.23"
      expect(menu.format_price(10033)).to eq "£100.33"
    end
    it "testing string to symbol method" do
      menu = InteractiveMenu.new
      expect(menu.string_to_symbol("Prawn curry")).to eq(:prawn_curry)
    end
  end
  context "viewing orders" do
    it "can view an order that is empty and return a message" do
      menu = InteractiveMenu.new
      order = double(:order)
      allow(order).to receive(:order).and_return({})
      expect(menu.view_order(order)).to eq "Order is empty: add something!"
    end
    it "can view a non empty order and return the formatted order" do
      menu = InteractiveMenu.new
      order = double(:order)
      allow(order).to receive(:order).and_return({prawn_curry: 2, chilli_beef: 1})
      expect(menu.view_order(order)).to eq "Your order:\nPrawn curry x 2 -- £11.00\nChilli beef x 1 -- £5.50\n******\nGrand total: £16.50"
    end
  end
  context "running the interactive menu" do
    it "can stop running when input is 5" do
      order = double(:order)
      menu = InteractiveMenu.new
      io = double(:io)
      time = 0
      expect(io).to receive(:puts).with("Welcome! Please type a number to get started:\n1. View menu\n2. View your order\n3. Add an item to your order\n4. Place your order\n5. Close the program")
      expect(io).to receive(:gets).and_return("5")
      menu.run(io, order, time)
    end
    it "returns error message when given invalid input" do
      menu = InteractiveMenu.new
      order = double(:order)
      io = double(:io)
      time = 0
      expect(io).to receive(:puts).with("Welcome! Please type a number to get started:\n1. View menu\n2. View your order\n3. Add an item to your order\n4. Place your order\n5. Close the program")
      expect(io).to receive(:gets).and_return("one")
      expect(io).to receive(:puts).with("Invalid number, please try again")
      expect(io).to receive(:puts).with("Welcome! Please type a number to get started:\n1. View menu\n2. View your order\n3. Add an item to your order\n4. Place your order\n5. Close the program")
      expect(io).to receive(:gets).and_return("5")
      menu.run(io, order, time)
    end
    it "can display the menu when input is 1" do
      menu = InteractiveMenu.new
      order = double(:order)
      io = double(:io)
      time = 0
      expect(io).to receive(:puts).with("Welcome! Please type a number to get started:\n1. View menu\n2. View your order\n3. Add an item to your order\n4. Place your order\n5. Close the program")
      expect(io).to receive(:gets).and_return("1")
      expect(io).to receive(:puts).with("Our menu:\nPrawn curry -- £5.50\nChilli beef -- £5.50\nEgg fried rice -- £3.00\nBoiled rice -- £2.40\nChicken chow mein -- £4.30")
      expect(io).to receive(:puts).with("Welcome! Please type a number to get started:\n1. View menu\n2. View your order\n3. Add an item to your order\n4. Place your order\n5. Close the program")
      expect(io).to receive(:gets).and_return("5")
      menu.run(io, order, time)
    end
    it "can display the order so far when input is 2" do
      menu = InteractiveMenu.new
      order = double(:order)
      time = 0
      allow(order).to receive(:order).and_return({prawn_curry: 2, chilli_beef: 1})
      io = double(:io)
      expect(io).to receive(:puts).with("Welcome! Please type a number to get started:\n1. View menu\n2. View your order\n3. Add an item to your order\n4. Place your order\n5. Close the program")
      expect(io).to receive(:gets).and_return("2")
      expect(io).to receive(:puts).with("Your order:\nPrawn curry x 2 -- £11.00\nChilli beef x 1 -- £5.50\n******\nGrand total: £16.50")
      expect(io).to receive(:puts).with("Welcome! Please type a number to get started:\n1. View menu\n2. View your order\n3. Add an item to your order\n4. Place your order\n5. Close the program")
      expect(io).to receive(:gets).and_return("5")
      menu.run(io, order, time)
    end    
    it "can add items to the order when input is 3" do
      menu = InteractiveMenu.new
      order = double(:order)
      io = double(:io)
      time = 0
      expect(io).to receive(:puts).with("Welcome! Please type a number to get started:\n1. View menu\n2. View your order\n3. Add an item to your order\n4. Place your order\n5. Close the program")
      expect(io).to receive(:gets).and_return("3")
      expect(io).to receive(:puts).with("What would you like to add?")
      expect(io).to receive(:gets).and_return("Prawn curry")
      expect(order).to receive(:add_to_order).with(:prawn_curry)
      expect(io).to receive(:puts).with("Added Prawn curry")
      expect(io).to receive(:puts).with("Welcome! Please type a number to get started:\n1. View menu\n2. View your order\n3. Add an item to your order\n4. Place your order\n5. Close the program")
      expect(io).to receive(:gets).and_return("5")
      menu.run(io, order, time)
    end
    it "returns message when adding something that doesnt exist" do
      menu = InteractiveMenu.new
      order = double(:order)
      io = double(:io)
      time = 0
      expect(io).to receive(:puts).with("Welcome! Please type a number to get started:\n1. View menu\n2. View your order\n3. Add an item to your order\n4. Place your order\n5. Close the program")
      expect(io).to receive(:gets).and_return("3")
      expect(io).to receive(:puts).with("What would you like to add?")
      expect(io).to receive(:gets).and_return("soap")
      expect(io).to receive(:puts).with("No such item, please try again (check spelling and capitalization)")
      expect(io).to receive(:puts).with("Welcome! Please type a number to get started:\n1. View menu\n2. View your order\n3. Add an item to your order\n4. Place your order\n5. Close the program")
      expect(io).to receive(:gets).and_return("5")
      menu.run(io, order, time)
    end
    it "can place order and send 'text' #TODO" do
      menu = InteractiveMenu.new
      order = double(:order)
      io = double(:io)
      time = Time.new(2022, 10, 20, 16, 16, 53)
      allow(order).to receive(:set_order_time).with(time)
      allow(order).to receive(:time_placed).and_return(time)
      allow(order).to receive(:format_time).with(time).and_return("16:16")
      expect(io).to receive(:puts).with("Welcome! Please type a number to get started:\n1. View menu\n2. View your order\n3. Add an item to your order\n4. Place your order\n5. Close the program")
      expect(io).to receive(:gets).and_return("4")
      expect(io).to receive(:puts).with("Order placed at 16:16")
      menu.run(io, order, time)
    end
  end
end
