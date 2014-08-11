Rails.application.routes.draw do
  resource :session, only: [:create, :new, :destroy]
  resources :users, except: :index
  resources :subs
  
  shallow do
    resources :posts, except: :index do
      post 'upvote', on: :member
      post 'downvote', on: :member
    
      resources :comments, only: [:create, :update, :destroy] do
        post 'upvote', on: :member
        post 'downvote', on: :member
      end
    end
  end
  
end
