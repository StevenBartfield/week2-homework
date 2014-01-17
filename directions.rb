require 'open-uri'
require 'json'

#request start location from the user
print "Enter an origin address: "
startLocation = gets
startLocation = startLocation.chomp  #remove new space

#request end location from the user
print "Enter an destination address: "
endLocation = gets
endLocation = endLocation.chomp  #remove new space

#parse the input by the spaces
arrStart = startLocation.split(' ') 
arrEnd = endLocation.split(' ')

#create 2 new concatenated string for API pull 
#(GoogAPI handles extrenious commas)
strAPIStartLocation = "" #instantiate
arrStart.each do |element|
	strAPIStartLocation += element + ",+"
end

strAPIEndLocation = "" #instantiate
arrEnd.each do |element|
	strAPIEndLocation += element + ",+"
end


#input the location and request the data
json_data = open("http://maps.googleapis.com/maps/api/directions/json?origin=#{strAPIStartLocation}&destination=#{strAPIEndLocation}&sensor=false").read

#stepwise parse the data from the api request
data = JSON.parse(json_data)
strDistance = data["routes"][0]["legs"][0]["distance"]["text"]
strTime = data["routes"][0]["legs"][0]["duration"]["text"]

#print the directions
print "Total travel time driving: "
puts strTime
print "Total distance traveled: "
puts strDistance



