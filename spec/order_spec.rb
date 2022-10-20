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
end