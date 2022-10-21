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
end