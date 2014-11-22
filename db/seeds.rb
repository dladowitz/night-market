# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create([
  { first_name: "David",  last_name: "Ladowitz", email_address: "david@ladowitz.com",     password: "asdfasdf", admin: true},
  { first_name: "Walter", last_name: "White",    email_address: "walter-white@gmail.com", password: "asdfasdf"},
])

events = Event.create([
  { user_id: 1, name: "Startup Weekend San Francisco", location: "San Francisco, CA", guests: 100, budget: 6000, start_date: 1.day.from_now, end_date: 3.days.from_now, vegetarian: true, gluten_free: true },
  { user_id: 1, name: "Startup Weekend London",        location: "London, England",   guests: 99,  budget: 6000, start_date: 1.day.from_now, end_date: 3.days.from_now, vegan: true },
  { user_id: 2, name: "Startup Weekend Albuquerque",      location: "Albuquerque, NM",      guests: 100, budget: 6000, start_date: 1.day.from_now, end_date: 3.days.from_now, vegetarian: true, gluten_free: true }
])

sf_event =     Event.first
london_event = Event.second
albuquerque  = Event.third

meals = Meal.create([
  { event: sf_event, category: "Dinner",    guests: 100, start: "2015-11-20T:18:00-08:00" },
  { event: sf_event, category: "Breakfast", guests: 100, start: "2015-11-21T:09:00-08:00" },
  { event: sf_event, category: "Lunch",     guests: 100, start: "2015-11-21T:12:00-08:00" },
  { event: sf_event, category: "Dinner",    guests: 100, start: "2015-11-21T:18:00-08:00" },
  { event: sf_event, category: "Breakfast", guests: 100, start: "2015-11-22T:09:00-08:00" },
  { event: sf_event, category: "Lunch",     guests: 100, start: "2015-11-22T:11:00-08:00" },
  { event: sf_event, category: "Dinner",    guests: 100, start: "2015-11-22T:15:00-08:00" },

  { event: london_event, category: "Dinner",    guests: 100, start: "2015-11-20T:18:00-08:00" },
  { event: london_event, category: "Breakfast", guests: 100, start: "2015-11-21T:09:00-08:00" },
  { event: london_event, category: "Lunch",     guests: 100, start: "2015-11-21T:12:00-08:00" },
  { event: london_event, category: "Dinner",    guests: 100, start: "2015-11-22T:18:00-08:00" },
  { event: london_event, category: "Breakfast", guests: 100, start: "2015-11-22T:09:00-08:00" },
  { event: london_event, category: "Lunch",     guests: 100, start: "2015-11-22T:12:00-08:00" },
  { event: london_event, category: "Dinner",    guests: 100, start: "2015-11-20T:17:00-08:00" },

  { event: albuquerque, category: "Dinner",    guests: 100, start: "2015-11-20T:18:00-08:00" },
  { event: albuquerque, category: "Breakfast", guests: 100, start: "2015-11-21T:09:00-08:00" },
  { event: albuquerque, category: "Lunch",     guests: 100, start: "2015-11-21T:12:00-08:00" },
  { event: albuquerque, category: "Dinner",    guests: 100, start: "2015-11-22T:18:00-08:00" },
  { event: albuquerque, category: "Breakfast", guests: 100, start: "2015-11-22T:09:00-08:00" },
  { event: albuquerque, category: "Lunch",     guests: 100, start: "2015-11-22T:12:00-08:00" },
  { event: albuquerque, category: "Dinner",    guests: 100, start: "2015-11-20T:17:00-08:00" },
])

sf_dinner_1    = sf_event.meals.first
sf_breakfast_1 = sf_event.meals[1]
albuquerque_breakfast_1 = albuquerque.meals.first

dishes = Dish.create([
  { meal:sf_dinner_1, name: "Sausage Pizza", vendor: "Patxis Pizza", needs_ordering: true,  ordered: false, servings: 75,  category: "Main",   transport_method: "Delivery", transport_time: sf_dinner_1.start - 30.minutes},
  { meal:sf_dinner_1, name: "Cheese Pizza",  vendor: "Patxis Pizza", needs_ordering: true,  ordered: false, servings: 25,  category: "Main",   vegetarian: true, transport_method: "Delivery", transport_time: sf_dinner_1.start - 30.minutes},
  { meal:sf_dinner_1, name: "Salad",         vendor: "Patxis Pizza", needs_ordering: true,  ordered: true,  servings: 75,  category: "Side1",  vegetarian: true, vegan: true, gluten_free: true, transport_method: "Delivery", transport_time: sf_dinner_1.start - 30.minutes},
  { meal:sf_dinner_1, name: "Breadsticks",   vendor: "Patxis Pizza", needs_ordering: true,  ordered: true,  servings: 100, category: "Side2",  vegetarian: true, vegan: true, transport_method: "Delivery" },
  { meal:sf_dinner_1, name: "Cookies",       vendor: "Safeway",      needs_ordering: false, ordered: nil,   servings: 100, category: "Desert", vegetarian: true, transport_method: "Pickup", transport_time: sf_dinner_1.start - 1.day},

  { meal:sf_breakfast_1, name: "Pastries", vendor: "Panera Bread", needs_ordering: true,  ordered: false, servings: 100, category: "Side1",  vegetarian: true, transport_method: "Delivery", transport_time: sf_dinner_1.start},
  { meal:sf_breakfast_1, name: "Yogurt",   vendor: "Safeway",      needs_ordering: false, ordered: nil,   servings: 75,  category: "Side2",  vegetarian: true, transport_method: "Pickup", transport_time: sf_dinner_1.start - 60.minutes},
  { meal:sf_breakfast_1, name: "Fruit",    vendor: "Safeway",      needs_ordering: false, ordered: false, servings: 100, category: "Side3",  vegetarian: true, vegan: true, gluten_free: true, transport_method: "Pickup", transport_time: sf_dinner_1.start - 60.minutes},
  { meal:sf_breakfast_1, name: "Muffins",  vendor: "Panera",       needs_ordering: true,  ordered: true,  servings: 75,  category: "Side2",  vegetarian: true, vegan: true, transport_method: "Delivery" },

  { meal:albuquerque_breakfast_1, name: "Pastries", vendor: "Panera Bread", needs_ordering: true,  ordered: false, servings: 100, category: "Side1",  vegetarian: true, transport_method: "Delivery", transport_time: sf_dinner_1.start},
  { meal:albuquerque_breakfast_1, name: "Yogurt",   vendor: "Safeway",      needs_ordering: false, ordered: nil,   servings: 75,  category: "Side2",  vegetarian: true, transport_method: "Pickup", transport_time: sf_dinner_1.start - 60.minutes},
  { meal:albuquerque_breakfast_1, name: "Fruit",    vendor: "Safeway",      needs_ordering: false, ordered: false, servings: 100, category: "Side3",  vegetarian: true, vegan: true, gluten_free: true, transport_method: "Pickup", transport_time: sf_dinner_1.start - 60.minutes},
  { meal:albuquerque_breakfast_1, name: "Muffins",  vendor: "Panera",       needs_ordering: true,  ordered: true,  servings: 75,  category: "Side2",  vegetarian: true, vegan: true, transport_method: "Delivery" },
])


