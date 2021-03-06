Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      get '/images' => 'images#index'
    end
  end

  get '/thumb/:width/:height/:filename.:extension' => 'thumb#index'
end
