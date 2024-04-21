# frozen_string_literal: true

Rails.application.routes.draw do
  get 'avui/demo1'
  get 'avui/demo2'
  get 'avui/demo3_initial'
  get 'avui/demo3'
  post '/avui/demo1/generate', to: 'avui#generate_demo1'
  post '/avui/demo2/generate', to: 'avui#generate_demo2'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: redirect("https://linkedin.com/in/olirods")

end
