# -*- encoding : utf-8 -*-
Rails.application.routes.draw do
  if Rubykassa::Client.configuration
    scope '/robokassa' do
      %w(paid success fail).map do |route|
        method(Rubykassa.http_method).call "/#{route}" => "robokassa##{route}", as: "robokassa_#{route}".to_sym 
      end
    end
  end
end
