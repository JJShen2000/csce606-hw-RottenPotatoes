# frozen_string_literal: true

Rails.application.routes.draw do
  resources :movies
  root to: redirect('/movies')
end
