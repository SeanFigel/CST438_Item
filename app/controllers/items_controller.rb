class ItemsController < ApplicationController
    
    def index
        # checks the params if the id is present
        if params['id'].present?
            # finds the Item values in the item variable
            item = Item.find_by(id: params['id'])
            # If the item variable is a nil after the search
            if item == nil
                head :not_found
            else
                render(json: item, status: 200)
            end
            
        else
            # returns 404
            head :not_found
        end
    end
    
    def create
        item = Item.new(item_params)
        if item.save
            data = format_item(item)
            render(json: data, status: 201)
        else
            render(json: item.errors, status: 400)
        end
    end
    
    def order
        if params.has_key?(:itemId)
            item = Item.find_by(id: params['itemId'])
            if item == nil
                head :not_found
                return
            end
            
            if item.stock > 0
                item.stock -= 1
            
                if item.save
                    # 204
                    head :no_content
                else
                    # 400
                    head :bad_request
                end
            else
                head :bad_request
            end
        else
            head :not_found
        end
    end
    
    def update
        if params.has_key?(:id)
            item = Item.find_by(id: params['id'])
            if item == nil
                head :not_found
                return
            end
            if item.update(description: params['description'], price: params['price'], stock: params['stock'])
                head :no_content
            else
                head :not_found 
            end
        else
            head :not_found
        end
    end
    
    private 
    
    def format_item(item)
        return{
            :id => item.id,
            :description => item.description,
            :price => item.price,
            :stock => item.stock
        }
    end
    
    def item_params
        params.require(:item).permit(:description, :price, :stock)
    end
end