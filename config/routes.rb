Rails.application.routes.draw do
  resources :images, only: [] do
    post :compress, action: :create, on: :collection
    get :download
  end
  
  root to: "images#new"
end
