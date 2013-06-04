Rubykassa.configure do |c|
  c.login = ENV["ROBOKASSA_LOGIN"]
  c.first_password = ENV["ROBOKASSA_FIRST_PASSWORD"]
  c.second_password = ENV["ROBOKASSA_SECOND_PASSWORD"]
  c.mode = :test
  c.http_method = "get"
end