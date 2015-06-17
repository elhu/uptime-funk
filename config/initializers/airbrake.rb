Airbrake.configure do |config|
  config.api_key = (ENV['AIBRAKE_API'] || "")
end
