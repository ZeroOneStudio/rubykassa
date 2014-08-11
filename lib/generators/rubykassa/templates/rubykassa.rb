# -*- encoding : utf-8 -*-
Rubykassa.configure do |config|
  config.login = ENV["ROBOKASSA_LOGIN"]
  config.first_password = ENV["ROBOKASSA_FIRST_PASSWORD"]
  config.second_password = ENV["ROBOKASSA_SECOND_PASSWORD"]
  config.mode = :test # or :production
  config.http_method = :get # or :post
  config.xml_http_method = :get # or :post


  # Result callback is called in RobokassaController#paid action if valid signature
  # was generated. It should always return "OK#{ invoice_id }" string, so implement
  # your custom logic above `controller.render text: notification.success` line

  config.result_callback = -> (controller, notification) { controller.render text: notification.success }

  # Define success or failure callbacks here like:

  # config.success_callback = -> (controller, notification) { controller.render text: 'success' }
  # config.fail_callback = -> (controller, notification) { controller.redirect_to controller.root_path }
end
