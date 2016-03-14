Rails.application.routes.draw do
  if Rubykassa::Client.configuration
    scope :robokassa do
      %w(result success fail).map do |route|
        match route,
              controller: :robokassa,
              action: route,
              via: Rubykassa.http_method
      end
    end
  end
end
