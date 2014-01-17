require 'open-uri'
require 'json'

#request location from the user
print "Enter an address, city, or zipcode: "
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

#stepwise parse the data from the api request
data = JSON.parse(json_data)
results = data["results"][0]["geometry"]["location"]

#print the latitude and longitude
print "Latitude:  "
puts results["lat"]
print "Longitude: "
puts results["lng"]
