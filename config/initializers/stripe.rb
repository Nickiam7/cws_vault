if Rails.env.production?
  Stripe.api_key = Rails.application.credentials.production[:stripe_private_key]
else
  Stripe.api_key = Rails.application.credentials.development[:stripe_private_key]
end
