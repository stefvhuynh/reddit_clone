Rails.application.routes.draw do
  resource :session, only: [:create, :new, :destroy]
  resources :users, except: :index
  
  shallow do
    resources :subs do
      resources :posts, except: :index do
        resources :comments, only: [:create, :update, :destroy]
      end
    end
  end
end
