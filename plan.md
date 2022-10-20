# {{PROBLEM}} Multi-Class Planned Design Recipe

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

_Consider diagramming out the classes and their relationships. Take care to
focus on the details you see as important, not everything. The diagram below
uses asciiflow.com but you could also use excalidraw.com, draw.io, or miro.com_

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

_Also design the interface of each class in more detail._

```ruby
class MusicLibrary
  def initialize
    # ...
  end

  def add(track) # track is an instance of Track
    # Track gets added to the library
    # Returns nothing
  end

  def all
    # Returns a list of track objects
  end
  
  def search_by_title(keyword) # keyword is a string
    # Returns a list of tracks with titles that include the keyword
  end
end

class Track
  def initialize(title, artist) # title and artist are both strings
  end

  def format
    # Returns a string of the form "TITLE by ARTIST"
  end
end
```

## 3. Create Examples as Integration Tests

_Create examples of the classes being used together in different situations and
combinations that reflect the ways in which the system will be used._

```ruby
# EXAMPLE

# Gets all tracks
library = MusicLibrary.new
track_1 = Track.new("Carte Blanche", "Veracocha")
track_2 = Track.new("Synaesthesia", "The Thrillseekers")
library.add(track_1)
library.add(track_2)
library.all # => [track_1, track_2]
```

## 4. Create Examples as Unit Tests

_Create examples, where appropriate, of the behaviour of each relevant class at
a more granular level of detail._

```ruby
# EXAMPLE

# Constructs a track
track = Track.new("Carte Blanche", "Veracocha")
track.title # => "Carte Blanche"
```

_Encode each example as a test. You can add to the above list as you go._

## 5. Implement the Behaviour

_After each test you write, follow the test-driving process of red, green,
refactor to implement the behaviour._