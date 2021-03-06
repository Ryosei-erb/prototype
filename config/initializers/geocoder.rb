if Rails.env.production?
Geocoder.configure(
  lookup: :google,
  api_key: ENV["GMAPS_API_KEY"],
  use_https: true,
  units: :km,
)
else
Geocoder.configure(
  lookup: :google,
  api_key: ENV["GMAPS_API_KEY"],
  use_https: true,
  units: :km,
)
end
