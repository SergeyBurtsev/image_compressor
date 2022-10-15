class Image < ApplicationRecord
  has_one_attached :image_file do |attachable|
    attachable.variant :compressed,
      format: :jpeg,
      saver: {
        subsample_mode: "on",
        strip: true,
        interlace: true,
        quality: 80,
      }
  end

  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :image_file, presence: true

  def compress
    image_file.variant(:compressed).processed.url
    true
  rescue Vips::Error
    false
  end
end
