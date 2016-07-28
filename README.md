# _PDX Food Collaborative_

#### **By Amber Baird, Nikki Garner, Leah Nelson, Cory Olson, Sam Park, Matt Wilkin**


## Minimum Viable Product


### Our Vision
  Most people in the western world create some sort of food waste. This gives the PDX Food Collaborative a broad and diverse market. Our aim is to reduce the waste of consumable food, however small that might be. According to the Food and Agriculture Organization, approximately 40% of the food in the US goes to waste while 50 million Americans live in food-insecure households. The PDX Food Collaborative aims to provide a platform where users who have surplus food can post their food and where the food can be picked up; meanwhile, other users who could use said surplus food, can look at the surplus food listings and send a message to coordinate a pick-up for the listing they are interested in.

### Our market

  The diversity of users range from single individuals, to families, farms, restaurants, non-profits, and groceries because food waste is universal. 

### Features
* User accounts
* Users are able to change their password
* A posting will detail the item name, category, source type, quantity, and location
* List posting source type as restaurant, brewery, general food business, grocery, farm, non-profit, or individual
* User can list posting with unique category that is stored within the database
* Users can update, delete and list their personal postings
* Users can send messages to posting author to discuss the "pick-up"
* Users have a private inbox to organize their private messages
* Users can share our About Us page via social media (Facebook and Twitter)
* Users can search for postings by category, location, or alphabetically (ascending and descending)

### Future Features
* Geolocates products via Google Maps API to show distance relative to user IP
* Users will be able to upload a photo of their listed product


## Objectives

* As a user, I want to be able to create my personal account.
* As a user, I want to be able to add, update, delete, and list foods (but only foods you listed).
* As a user, I want to be able to list foods and categorize them alphabetically, location, serving size, and entity.
* As a user, I want to be able to see foods listed by category (dairy, meat, veggie, fruit, etc).
* As a user, I want to be able to see what kind of entity is listing the food (individual, restaurant, brewery, grocery, farm, food business, non-profit etc)
* As a user, I want to be able to see all of the foods available on the exchange.
* As a user, I want food names and locations to be saved with a capital letter no matter how I enter them.
* As a user, I do not want foods to be saved if I enter a blank name.
* As a user, I want to be able to share listings via social media.
* As a user, I want to be able to send messages to food listers to set up a pick up location and time.
* As a user, I want to be able to receive messages from people who are interested in picking up my food.
* As a user, I want to be able to have a map that geolocates products listed.


## Specifications
See spec folder

## Technologies Used
* Markdown
* HTML
* Ruby
* Sinatra
* Pry
* CSS


## Setup/Installation Requirements

#### Setup instructions
* Clone this repository
* Navigate into file
* Connect to postgres
* Enter commands:
  * rake db:create
  * rake db:migrate
* Open in Sinatra
* Navigate to localhost:4567

## Known Bugs
* None

This software is licensed under the MIT License and the **_Mind Your Own Beeswax license._**

Copyright &copy; 2016 Amber Baird, Nikki Garner, Leah Nelson, Cory Olson, Sam Park, Matt Wilkin
