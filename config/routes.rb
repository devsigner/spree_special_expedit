# -*- encoding : utf-8 -*-
Rails.application.routes.draw do
  
  namespace :admin do
    resource :myshop_settings do
    end
  end
  
end
