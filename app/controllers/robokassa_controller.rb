# -*- encoding : utf-8 -*-
class RobokassaController < ApplicationController
  before_filter :create_notification, except: :fail

  def paid
    if @notification.valid_result_signature?
      render text: @notification.success
    else
      render text: "fail"
    end
  end

  def success
    if @notification.valid_success_signature?
      render text: "success"
    else
      render text: "fail"
    end
  end

  def fail
    render text: "fail"
  end

  private

    def create_notification
      @notification = Rubykassa::Notification.new request.query_parameters
    end
end
