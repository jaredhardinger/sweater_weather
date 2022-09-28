# SWEATER WEATHER

![ruby](https://img.shields.io/badge/Ruby-2.7.4-red)
![rails](https://img.shields.io/badge/Rails-6.1.7-red)
![rspec](https://img.shields.io/badge/RSpec-3.11.0-green)
![contributors](https://img.shields.io/badge/Contributors-1-yellow)

## Table of Contents
- [Sweater Weather](#wetectives-back-end-repo)
  - [Table of Contents](#table-of-contents)
  - [App](#app)
  - [Background](#background)
  - [Schema](#schema)
  - [Endpoints](#endpoints)
  - [Installation](#installation)
  - [Contributors](#contributors)

## App

This is a backend Ruby on Rails API-based application. 

## Background

The Sweater Weather app exists to receive a JSON request to one of its API endpoints and then send a JSON response containing the appropriate data. Depending on the endpoint, the request will:
- send a location to recieve that location's forecast in return
- send an email, password, and password_confirmation to create a new user and recieve a 'successful' or 'unsuccessful' response
- send an email and password to login a user and receive an api_key in its response
- send an origin, destination, and valid api_key to receive a total travel time and arrival forecase in its response

These requests will consume the [OpenWeather One Call API](https://openweathermap.org/api/one-call-api) as well as MapQuest's [Geocoding](https://developer.mapquest.com/documentation/geocoding-api/) and [Directions](https://developer.mapquest.com/documentation/directions-api/) APIs in order to expose the relevant data.

## Schema

![Screen Shot 2022-09-28 at 10 39 32 AM](https://user-images.githubusercontent.com/80866068/192809045-b527c151-153c-437e-b812-fa23b0e170de.png)



## Endpoints

- Retrieve Weather for a City
```ruby
#Request:

GET /api/v1/forecast?location=denver,co
Content-Type: application/json
Accept: application/json

#Response:

{
  "data": {
    "id": null,
    "type": "forecast",
    "attributes": {
      "current_weather": {
        "datetime": "2020-09-30 13:27:03 -0600",
        "temperature": 79.4,
        etc
      },
      "daily_weather": [
        {
          "date": "2020-10-01",
          "sunrise": "2020-10-01 06:10:43 -0600",
          etc
        },
        {...} etc
      ],
      "hourly_weather": [
        {
          "time": "14:00:00",
          "conditions": "cloudy with a chance of meatballs",
          etc
        },
        {...} etc
      ]
    }
  }
}
```

- User Registration
```ruby
#Request:

POST /api/v1/users
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}

#Response:

status: 201
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```

- User Login
```ruby
#Request:

POST /api/v1/sessions
Content-Type: application/json
Accept: application/json

#Response:

status: 200
body:

{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```

- Road Trip
```ruby
#Request:

POST /api/v1/road_trip
Content-Type: application/json
Accept: application/json

body:

{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}

#Response:

{
  "data": {
    "id": null,
    "type": "roadtrip",
    "attributes": {
      "start_city": "Denver, CO",
      "end_city": "Estes Park, CO",
      "travel_time": "2 hours, 13 minutes"
      "weather_at_eta": {
        "temperature": 59.4,
        "conditions": "partly cloudy with a chance of meatballs"
      }
    }
  }
}
```
## Installation

1. Clone this repository to your local machine and navigate to the root of that project's directory


2. In your terminal, install required Gems
```shell
$ cd bundle install
```

3. Migrate your database
```shell
$ rails db:{drop,create,migrate,seed}
```

4. Start a rails server
```shell
$ rails s
```

5. Call on the endpoints above using a client like [Postman](https://www.postman.com/), or build out a frontend of your own!

6. Have fun!

## Contributors
|  | |
| --- | --- |

Jared Hardinger | [GitHub](https://github.com/jaredhardinger) &#124; [LinkedIn](https://www.linkedin.com/in/hardinger/) 
