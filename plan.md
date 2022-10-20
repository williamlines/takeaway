# {{PROBLEM}} Takeaway Design Plan

## 1. Describe the Problem
As a customer
So that I can check if I want to order something
I would like to see a list of dishes with prices.

As a customer
So that I can order the meal I want
I would like to be able to select some number of several available dishes.

As a customer
So that I can verify that my order is correct
I would like to see an itemised receipt with a grand total.

# Using twilio-ruby

As a customer
So that I am reassured that my order will be delivered on time
I would like to receive a text such as "Thank you! Your order was placed and will be delivered before 18:52" after I have ordered.

## 2. Design the Class System

made with asciiflow.com
```
                   INTERACTIVE MENU
┌──────────────────────────────────────────────────┐
│   Initializes with:                              │
│                                                  │
│   @dishes- hash of available dishes with prices  │
│                                                  │
│                                                  │
│                                                  │
│   METHODS:                                       │
│                                                  │
│   -run  calls methods from this and other classes│
│         to interact with customer                │
│                                                  │
│                                                  │
│                                                  │
│                                                  │
│                                                  │
│                                                  │
│                                                  │
│                                                  │
│                                                  │
│                                                  │
│                                                  │
└─────────────────────────┬────────────────────────┘
                          │
              ORDER       │                                              ▼
┌─────────────────────────▼────────────────────────┐
│   Initializes with:                              │
│                                                  │
│   @order- hash containing ordered dishes and     │
│           quantity ordered                       │
│                                                  │
│   @time_placed- initially zero, a string of the  │
│                 time an order was placed         │
│                                                  │
│   -add_to_order adds new item to the order       │
│                                                  │
│   -view order   puts the order with dishes       │
│                 ordered, their quantities and    │
│                 individual costs, and grand total│
│                                                  │
│   -set_order_time updates @time_placed to current│
│                   time                           │
│                                                  │
│   -time_placed  returns @time_placed             │
│                                                  │
│   -order        returns @order                   │
│                                                  │
│   -confirmation_text sends confirmation text with│
│                      delivery time               │
│                                                  │
│   -delivery_time  calculates delivery time       │
│                                                  │
│                                                  │
│                                                  │
│                                                  │
│                                                  │
└──────────────────────────────────────────────────┘
```

## In more detail:

```ruby
class InteractiveMenu
  def initialize
    # @dishes = {:prawn_curry : 550 ...} key = dish, value = price
  end

  def run
    #runs program using other methods
  end

  def display_menu
    #displays menu
  end
end

class Order
  def initialize
    # @order = {:prawn_curry : 1} hash key = dish, value = quantity
    # @time_placed = 0     time order placed initially zero
  end

  def add_to_order(item)
    # adds item to order
  end

  def view_order 
    # displays order with dishes, quantity and total price
  end
  
  def set_order_time
    # updates @time_placed to current time
  end

  def time_placed
    # return @time_placed
  end

  def order
    # return @order
  end

  def delivery_time
    # calculates est. time to delivery
  end

  def confirmation_text
    # sends confirmation text with delivery time
  end

  def format_symbol(symbol)
    # converts symbol e.g :prawn_curry => "Prawn curry"
  end

  def format_price(price)
    # converts price to readable e.g 550 => "£5.50"
  end
  
  def format_time
    # formats current @time_placed to readable format e.g 2022-10-20 16:16:53.303608 +0100 => 16:16
  end
end
```

## Example Integration Tests (TODO)



```ruby
# Interactive menu can display menu
  menu = InteractiveMenu.new
  menu.display_menu => "....."


```

## Example as Unit Tests

_Create examples, where appropriate, of the behaviour of each relevant class at
a more granular level of detail._

```ruby
# Order constructs
order = Order.new
order.order => {}
order.time_placed => # 0

# order can add new item 
order = Order.new
order.add_to_order(:prawn_curry)
order.order => {:prawn_curry : 1}

# order can add new item multiple times
order = Order.new
order.add_to_order(:prawn_curry)
order.order => # {:prawn_curry : 1}
order.add_to_order(:prawn_curry)
order.order => # {:prawn_curry : 2}

# order can add multiple new items
order = Order.new
order.add_to_order(:prawn_curry)
order.order => # {:prawn_curry : 1}
order.add_to_order(:chilli_beef)
order.order => # {:prawn_curry : 1, :chilli_beef : 1}

# testing symbol formatter
order = Order.new
order.format_symbol(:prawn_curry) => # "Prawn curry"
order.format_symbol(:this_symbol_is_way_longer_than_usual) => # "This symbol is way longer than usual"

# test price formatter
order = Order.new
order.format_price(100) => # "£1"
order.format_price(550) => # "£5.50"
order.format_price(123) => # "£1.23"
order.format_price (10033) => # "£100.33"

# can view order when empty
order = Order.new
order.view_order => # "Order is empty: add something!"

# can view order when not empty
order = Order.new
order.add_to_order(:prawn_curry)
order.add_to_order(:chilli_beef)
order.add_to_order(:prawn_curry)
order.view_order => # "Your order:\nPrawn curry x 2 -- £11\nChilli beef x 1 -- £5.50\n******\nGrand total: £16.50"

# testing order time setting and returning
order = Order.new
order.time_placed => # 0
order.set_order_time
order.time_placed => # 2022-10-20 16:16:53.303608 +0100

# testing format_time
order = Order.new
order.set_order_time # time is 2022-10-20 16:16:53.303608 +0100
order.format_time => # 16:16

# testing delivery time
order = Order.new
order.set_order_time # time is 2022-10-20 16:16:53.303608 +0100
order.delivery_time => # 16:46
```



## Implement the Behaviour

# Repeat the Testing => Implementation loop