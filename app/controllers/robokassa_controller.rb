class RobokassaController < ActionController::Base
  if respond_to?(:before_action)
    before_action :create_notification
  else
    before_filter :create_notification
  end

  def result
    if @notification.valid_result_signature?
      instance_exec @notification, &Rubykassa.result_callback
    else
      instance_exec @notification, &Rubykassa.fail_callback
    end
  end

  def success
    if @notification.valid_success_signature?
      instance_exec @notification, &Rubykassa.success_callback
    else
      instance_exec @notification, &Rubykassa.fail_callback
    end
  end

  def fail
    instance_exec @notification, &Rubykassa.fail_callback
  end

  private

  def create_notification
    if request.get?
      @notification = Rubykassa::Notification.new request.query_parameters
    elsif request.post?
      @notification = Rubykassa::Notification.new request.request_parameters
    end
  end
end
