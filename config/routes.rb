Rails.application.routes.draw do
  root "home#index"
  get "/signup", to: "users#signup"
  post "/signup", to: "users#createuser"

  get "/login", to: "users#login"
  post "/login", to: "users#authenticate"

  get "/profile", to: "users#profile"
  get "/products", to: "products#showAll"

  get "/logout", to: "users#logout"

  get "/products/addproduct", to: "products#addProduct"
  post "/products", to: "products#createProduct"
  delete "/products/:id", to: "products#deleteProduct"
  get "/products/:id/edit", to: "products#edit"
  patch "/products/:id", to: "products#update"

  delete "/product_images/:id", to: "product_images#deleteImage"
end
