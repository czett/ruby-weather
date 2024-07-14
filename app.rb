require 'net/http'
require 'json'

API_KEY = '4c7e7ac9ed08b686ec3b501a2ee604c3'
BASE_URL = 'http://api.openweathermap.org/data/2.5/weather'

def clear
  system("clear")
end

def display_weather(weather_data)
  begin
    city = weather_data['name']
    temperature = weather_data['main']['temp']
    description = weather_data['weather'][0]['description']

    puts "Weather in #{city}:"
    puts "Temperature: #{temperature}°C"
    puts "Conditions: #{description}\n\n"
  rescue
    puts "There has been an error.\n"
  end
end

def fetch_weather(city)
  url = "#{BASE_URL}?q=#{city}&appid=#{API_KEY}&units=metric"
  uri = URI(url)
  response = Net::HTTP.get(uri)
  $data = JSON.parse(response)
  display_weather($data)
end

puts "Welcome to Ruby Weather"

while true
  puts "Enter a city ('exit' to exit the program): "
  $city = gets.chomp.capitalize

  if $city == "Exit"
    clear
    break
  end

  clear
  fetch_weather($city)
end
