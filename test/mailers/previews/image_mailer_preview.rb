# Preview all emails at http://localhost:3000/rails/mailers/image_mailer
class ImageMailerPreview < ActionMailer::Preview
  def compression_good
    image = Image.new(id: SecureRandom.uuid)
    ImageMailer.compression_good(image)
  end

  def compression_bad
    image = Image.new(id: SecureRandom.uuid)
    ImageMailer.compression_bad(image)
  end
end
