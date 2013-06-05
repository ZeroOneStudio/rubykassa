# -*- encoding : utf-8 -*-
Dummy::Application.routes.draw do
  get "welcome/index"

  root to: 'welcome#index'
end
