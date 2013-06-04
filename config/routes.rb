Rails.application.routes.draw do
  scope '/robokassa' do
    get '/paid'    => 'robokassa#paid',    as: :robokassa_paid
    get '/success' => 'robokassa#success', as: :robokassa_success
    get '/fail'    => 'robokassa#fail',    as: :robokassa_fail
  end
end
