class RobokassaController < ApplicationController
  before_filter :create_notification, except: :fail

  def paid
    render text: @notification.generate_signature_for(:response)
  end

  def success
    render text: "success"
  end

  def fail
    render text: "fail"
  end

private

  def create_notification
    logger.info params
    @notification = Rubykassa::Notification.new params
    logger.info @notification.params
  end
end
