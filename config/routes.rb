Rails.application.routes.draw do
    resources :items, :only => [:index, :create, :update] do
        # Sub dir 
        collection do 
            put 'order'
        end
    end
    get('status' => 'status#index')
    post('status' => 'status#index')
    
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
