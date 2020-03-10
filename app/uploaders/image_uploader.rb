class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_fill: [1200, 1200, "center"]
  version :product do
    process resize_to_limit: [300, 300]
  end
  version :large do
    process resize_to_limit: [500, 500]
  end
  version :small do
    process resize_to_limit: [48, 48]
  end

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpeg jpg gif png)
  end
end
