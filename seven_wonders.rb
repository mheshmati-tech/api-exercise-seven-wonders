require "httparty"
require "dotenv"
Dotenv.load

BASE_URL = "https://us1.locationiq.com/v1/search.php"
LOCATION_IQ_KEY = ENV["API_TOKEN"]

#url is the base pathway 
#depending on how the arrangement to access the API (should look at their API documentation), arrange the pathway 
#in this case it was the auth-token, the place (search_term), then the format
#once you access that data- retrieve data how you normally would from array and hashes 
#need to place a raise and rescue in case the response within the request/response is not "okay"
#reminder= what HTTParty gives back is a class object so can use .code .message, etc so investigate further 



def get_location(search_term)
  query_parameters = {
    key: LOCATION_IQ_KEY,
    q: search_term.to_s,
    format: "json",
  }

  response = HTTParty.get(BASE_URL, query: query_parameters)
  if response.code != 200
    raise(ArgumentError, respone["message"])
  else
    return { name: search_term,
            lat: response[0]["lat"],
            lon: response[0]["lon"] }
  end
end

def find_seven_wonders
  seven_wonders = ["Great Pyramid of Giza", "Gardens of Babylon", "Colossus of Rhodes", "Pharos of Alexandria", "Statue of Zeus at Olympia", "Temple of Artemis", "Mausoleum at Halicarnassus"]

  seven_wonders_locations = []

  seven_wonders.each do |wonder|
    sleep(0.5)
    seven_wonders_locations << get_location(wonder)
  end

  return seven_wonders_locations
end

puts "#{find_seven_wonders}"
# Expecting something like:
# [{"Great Pyramid of Giza"=>{:lat=>"29.9791264", :lon=>"31.1342383751015"}}, {"Gardens of Babylon"=>{:lat=>"50.8241215", :lon=>"-0.1506162"}}, {"Colossus of Rhodes"=>{:lat=>"36.3397076", :lon=>"28.2003164"}}, {"Pharos of Alexandria"=>{:lat=>"30.94795585", :lon=>"29.5235626430011"}}, {"Statue of Zeus at Olympia"=>{:lat=>"37.6379088", :lon=>"21.6300063"}}, {"Temple of Artemis"=>{:lat=>"32.2818952", :lon=>"35.8908989553238"}}, {"Mausoleum at Halicarnassus"=>{:lat=>"37.03788265", :lon=>"27.4241455276707"}}]
