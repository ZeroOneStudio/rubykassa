Rails.application.routes.draw do
  scope 'robokassa' do
    match 'paid'    => 'robokassa#paid',    as: :robokassa_paid
    match 'success' => 'robokassa#success', as: :robokassa_success
    match 'fail'    => 'robokassa#fail',    as: :robokassa_fail
  end
end
