require 'httparty'

# connection defined here

class Connection
    include HTTParty
    base_uri 'http://localhost:8080'
    headers 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'
    format :json
end

# is passed the response from a http request and prints the
# status code and the response returned from the reqeust
def outputResponseCode(response)
   puts "status code #{response.code}"
   puts response
end

userInput = nil
# loop to run client until the user types quit
while userInput != 'quit'
puts 'What do you want to do: create, update, get or quit'
userInput = gets.chomp!

if userInput == 'create'
    puts "enter item description"
    name = gets.chomp!
    puts 'enter item price'
    cost = gets.chomp!
    puts 'enter item stockQty'
    numOnHand = gets.chomp!
    obj = {description: name, price: cost, stock: numOnHand}
    outputResponseCode(Connection.post('/items', :body => obj.to_json))

elsif userInput == 'update'
    puts "enter id of item to update"
    idValue = gets.chomp!
    puts "enter description"
    name = gets.chomp!
    puts "enter price"
    cost = gets.chomp!
    puts "enter stockQty"
    numOnHand = gets.chomp!
    obj = {id: idValue, description: name, price: cost, stock: numOnHand }
    update_response = Connection.put("/items/#{idValue}", :body => obj.to_json)
    puts "status code #{update_response.code}"

elsif userInput == 'get'
    puts "enter id of item to lookup"
    idInput = gets.chomp!
    outputResponseCode(Connection.get('/items', query: {id: idInput}))
    #connection .get('/items',query: user input
end
end