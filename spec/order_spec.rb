require "order"

RSpec.describe Order do
  it "constructs" do
    order = Order.new
    expect(order.order).to eq({})
    expect(order.time_placed).to eq(0)
  end
  
  context "adding items to the order" do
    it "can add one item" do
      order = Order.new
      order.add_to_order(:prawn_curry)
      expect(order.order).to eq({prawn_curry: 1})
    end
  
    it "can add one item multiple times" do
      order = Order.new
      order.add_to_order(:prawn_curry)
      order.add_to_order(:prawn_curry)
      expect(order.order).to eq({prawn_curry: 2})
    end

    it "can add multiple new items" do
      order = Order.new
      order.add_to_order(:prawn_curry)
      order.add_to_order(:chilli_beef)
      order.add_to_order(:chilli_beef)
      expect(order.order).to eq({
        prawn_curry: 1,
        chilli_beef: 2})
    end
  end
  context "testing formatters" do
    it "testing symbol formatter" do
      order = Order.new
      expect(order.format_symbol(:prawn_curry)).to eq "Prawn curry"
      expect(order.format_symbol(:this_symbol_is_way_longer_than_usual)).to eq "This symbol is way longer than usual"
    end
    it "testing price formatter" do
      order = Order.new
      expect(order.format_price(100)).to eq "£1.00"
      expect(order.format_price(550)).to eq "£5.50"
      expect(order.format_price(123)).to eq "£1.23"
      expect(order.format_price(10033)).to eq "£100.33"
    end
      it "testing time formatter" do
      order = Order.new
      time = Time.new(2022, 10, 20, 16, 16, 53)
      order.set_order_time(time) # time is 2022-10-20 16:16:53.303608 +0100
      expect(order.format_time(order.time_placed)).to eq "16:16"
      time = Time.new(2022, 10, 20, 17, 35, 53)
      order.set_order_time(time) # time is 2022-10-20 16:16:53.303608 +0100
      expect(order.format_time(order.time_placed)).to eq "17:35"
    end
  end
  it "can calculate estimated delivery time" do
    order = Order.new
    time = Time.new(2022, 10, 20, 16, 16, 53)
    order.set_order_time(time) # time is 2022-10-20 16:16:53.303608 +0100
    expect(order.delivery_time).to eq "16:46"
    time = Time.new(2022, 10, 20, 17, 35, 53)
    order.set_order_time(time)
    expect(order.delivery_time).to eq "18:05"
  end
end
