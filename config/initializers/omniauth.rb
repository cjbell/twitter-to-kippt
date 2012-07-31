OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "Q9W3Q6mYIRxsreUbwPTkLw", "J3W5QiGeuULP6HP8iDTe8EsQCQJyK0V4Fx2qlBUMEw" 
end