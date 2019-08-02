require 'rails_helper'
require 'pp'

# happy and sad test for all routes

RSpec.describe 'Item requests' do
    headers = {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
    
    before(:each) do 
        Item.create(description: 'Diamond Ring', price: 1524.53, stock: 5)
        Item.create(description: 'Ruby Ring', price: 1452.53, stock: 5)
        Item.create(description: 'Saphire Ring', price: 824.53, stock: 0)
        
    end
    #happy test
    describe 'GET /item/id' do
        it 'returns an array of item details' do
            get '/items?id=2', headers: headers
            expect(response).to have_http_status(200)
            item_returned = JSON.parse(response.body)
            expect(item_returned['id']).to eq 2
            
        end
        
        #sad test
        it 'Checks for out of range id' do
            get '/items?id=7', headers: headers
            expect(response).to have_http_status(404)
        end
        
        
    end
    # happy test
    describe 'POST /items' do
       it 'Creates a valid item' do
           new_item = {description: 'Gold Ring', price: 1102.25, stock: 2}
           post '/items', params: new_item.to_json, headers: headers
           expect(response).to have_http_status(201)
       end
       # sad test
        it 'Fail to create a valid item because the price must be greater than 0' do
            new_item = {description: 'Computer', price: 0, stock: 2}
            post '/items', params: new_item.to_json, headers: headers
            expect(response).to have_http_status(400)
        end
        it 'Fail to create a valid item because stock cannot be below 0' do
            new_item = {description: 'Computer', price: 1122.45, stock: -1}
            post '/items', params: new_item.to_json, headers: headers
            expect(response).to have_http_status(400)
        end
        it 'Fail to create a valid item because stock must be an integer' do
            new_item = {description: 'Computer', price: 124.52, stock: 2.5}
            post '/items', params: new_item.to_json, headers: headers
            expect(response).to have_http_status(400)            
        end
        it 'Fail to create a valid item because no data' do
            new_item = {description: ''}
            post '/items', params: new_item.to_json, headers: headers
            expect(response).to have_http_status(400)            
        end
        
        it 'Fail to create a valid item because no data' do
            new_item = {price: nil}
            post '/items', params: new_item.to_json, headers: headers
            expect(response).to have_http_status(400)            
        end
        it 'Fail to create a valid item because no data' do
            new_item = {stock: nil}
            post '/items', params: new_item.to_json, headers: headers
            expect(response).to have_http_status(400)            
        end        
        
    end
    
    describe 'PUT /items/order' do
        it 'Updates the stock to reflect the order. Does not process order if stock is zero' do
            item_order = {id: 1, itemId: 2, description: 'Ruby Ring', customerId: 1, price: 1452.53, award: 0, total: 1452.53 }
            put '/items/order', params: item_order.to_json, headers: headers
            expect(response).to have_http_status(204)
            item = Item.find_by(id: 2)
            expect(item['description']).to eq 'Ruby Ring'
            expect(item['stock']).to eq 4
        end
        
        it 'Checks for out of range id' do
            item_order = {id: 1, itemId: 6, description: 'Ruby Ring', customerId: 1, price: 1452.53, award: 0, total: 1452.53 }
            put '/items/order', params: item_order.to_json, headers: headers
            expect(response).to have_http_status(404)
            
        end
        
        it 'Fails due to the stock being zero' do
            item_order = {id: 1, itemId: 3, description: 'Saphire Ring', customerId: 1, price: 824.53, award: 0, total: 1452.53 }
            put '/items/order', params: item_order.to_json, headers: headers
            expect(response).to have_http_status(400)
        end
    end
    
    describe 'PUT /items/:id' do
       it 'Updates the item' do
          item = {id: 2, description: 'Gold Watch', price: 982.25, stock: 2} 
          put "/items/#{item[:id]}", params: item.to_json, headers: headers
          expect(response).to have_http_status(204)
       end
       
       it 'Fails to update' do
            item = {id: 9, description: 'Gold Watch', price: 982.25, stock: 2} 
            put "/items/#{item[:id]}", params: item.to_json, headers: headers
            expect(response).to have_http_status(404)
       end
        it 'Fails to update due to missing the param description' do
            item = {id: 1, price: 982.25, stock: 2} 
            put "/items/#{item[:id]}", params: item.to_json, headers: headers
            expect(response).to have_http_status(404)
       end
       
    end
end  
