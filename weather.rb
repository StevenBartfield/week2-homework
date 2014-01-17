require 'open-uri'
require 'json'

####################
##Get Lat/Long from Google API 
##Allows for more robust user input
####################

#request location from the user
print "Please enter an address: "
requestedLocation = gets
requestedLocation = requestedLocation.chomp  #remove new space

#parse the input by the spaces
arrRequest = requestedLocation.split(' ') 

#create new concatenated string for API pull 
#(GoogAPI handles extrenious commas)
strAPILocation = "" #instantiate
arrRequest.each do |element|
	strAPILocation += element + ",+"
end

#input the location and request the data
json_data = open("http://maps.googleapis.com/maps/api/geocode/json?address=#{strAPILocation}&sensor=false").read

# parse the data from the api request to latitude and longitude
data = JSON.parse(json_data)
results = data["results"][0]["geometry"]["location"]
nLatitude  = results["lat"]
nLongitude = results["lng"]

########################
##Input Lat/Long into weather API
########################

json_data = open("http://api.openweathermap.org/data/2.5/weather?lat=#{nLatitude}&lon=#{nLongitude}").read
#parse the data from the api request
data = JSON.parse(json_data)
result = data["main"]["temp"]
#temp in kelvin - convert to Fahrenheit
convertedFahr = ((result - 273.15) * 1.8) + 32

#print to the temp (round to one decimal)
print (convertedFahr*10).round / 10.0
puts "f"


