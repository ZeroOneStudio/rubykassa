# -*- encoding : utf-8 -*-
class RobokassaController < ApplicationController
  before_filter :create_notification, except: :fail

  def paid
    if @notification.valid_result_signature?
      render text: @notification.success
    else
      Rubykassa.fail_callback.call
    end
  end

  def success
    if @notification.valid_success_signature?
      Rubykassa.success_callback.call
    else
      Rubykassa.fail_callback.call
    end
  end

  def fail
    Rubykassa.fail_callback.call
  end

  private

    def create_notification
      @notification = Rubykassa::Notification.new request.query_parameters
    end
end
