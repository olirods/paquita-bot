# frozen_string_literal: true

Rails.application.routes.draw do
  get 'avui/demo1'
  get 'avui/demo2'
  post '/avui/demo1/generate', to: 'avui#generate_demo1'
  post '/avui/demo2/generate', to: 'avui#generate_demo2'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
