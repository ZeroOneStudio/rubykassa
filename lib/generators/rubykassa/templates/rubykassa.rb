# -*- encoding : utf-8 -*-
Rubykassa.configure do |c|
  c.login = ENV["ROBOKASSA_LOGIN"]
  c.first_password = ENV["ROBOKASSA_FIRST_PASSWORD"]
  c.second_password = ENV["ROBOKASSA_SECOND_PASSWORD"]
  c.mode = :test # or :production
  c.http_method = :get # or :post
  c.xml_http_method = :get # or :post

  # Define success or failure callbacks here like:

  # config.success_callback = -> (controller, notification){ render text: 'success' }
  # config.fail_callback = -> (controller, notification){ redirect_to root_path }
end
