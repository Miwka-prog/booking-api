class ApartmentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_allowlist
    %w[jpg jpeg png]
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  def size_range
    (1.byte)..(3.megabytes)
  end

  protected

  def secure_token
    variable = :"@#{mounted_as}_secure_token"
    model.instance_variable_set(variable, SecureRandom.uuid)
  end
end
