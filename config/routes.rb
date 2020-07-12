Rails.application.routes.draw do
  get "/shelters", to: "shelters#index"
  get "/shelters/new", to: "shelters#new"
  get "/shelters/:id", to: "shelters#show"
  post "/shelters", to: "shelters#create"
  get "/shelters/:id/edit", to: "shelters#edit"
  patch "/shelters/:id", to: "shelters#update"
  delete "/shelters/:id", to: "shelters#destroy"

  get "/pets", to: "pets#index"
  get "/pets/:id", to: "pets#show"
  get "/pets/:id/edit", to: "pets#edit"
  patch "/pets/:id", to: "pets#update"
  delete "pets/:id", to: "pets#destroy"

  get "/shelters/:id/pets", to: "shelters#pets_index"

  get "/shelters/:id/pets/new", to: "pets#new"
  post "/shelters/:id/pets", to: "pets#create"

  get "/", to: "welcome#index"

  get "/shelters/:id/reviews/new", to: "reviews#new"
  post "/shelters/:id/reviews", to: "reviews#create"
  get "/shelters/:id/reviews/:review_id/edit", to: "reviews#edit"
  patch "/shelters/:id/reviews/:review_id", to: "reviews#update"
  delete "/shelters/:id/reviews/:review_id", to: "reviews#destroy"

  patch "/favorites/:pet_id", to: "favorites#update"
end
