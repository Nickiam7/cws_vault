CarrierWave.configure do |config|
  config.fog_credentials = {
     provider:               'AWS',
     aws_access_key_id:      Rails.application.credentials.aws_access_key_id,
     aws_secret_access_key:  Rails.application.credentials.aws_secret_access_key,
     region:                 Rails.application.credentials.aws_region_name
  }
  if Rails.env.production?
     config.fog_directory  = Rails.application.credentials.production[:aws_bucket]
  else
     config.fog_directory  = Rails.application.credentials.development[:aws_bucket]
  end
  config.fog_public        = true
end
