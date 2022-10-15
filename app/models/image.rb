class Image < ApplicationRecord
  COMPRESSION_SETTINGS = {
    format: :jpeg,
    saver: {
      subsample_mode: "on",
      strip: true,
      interlace: true,
      quality: 80,
    }
  }

  has_one_attached :image_file do |attachable|
    attachable.variant :compressed, COMPRESSION_SETTINGS
  end

  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :image_file, presence: true

  def compress?
    image_file.variant(:compressed).processed.url
    true
  rescue ActiveStorage::InvariableError, Vips::Error
    false
  end
end
