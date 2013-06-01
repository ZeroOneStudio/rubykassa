class RobokassaController < ApplicationController
  def paid
    render text: "paid"
  end

  def success
    render text: "success"
  end

  def fail
    render text: "fail"
  end
end
