# -*- encoding : utf-8 -*-
class RobokassaController < ApplicationController
  before_filter :create_notification

  def paid
    if @notification.valid_result_signature?
      Rubykassa.result_callback.call(self, @notification)
    else
      Rubykassa.fail_callback.call(self, @notification)
    end
  end

  def success
    if @notification.valid_success_signature?
      Rubykassa.success_callback.call(self, @notification)
    else
      Rubykassa.fail_callback.call(self, @notification)
    end
  end

  def fail
    Rubykassa.fail_callback.call(self, @notification)
  end

  private

    def create_notification
      @notification = Rubykassa::Notification.new request.query_parameters
    end
end
