class ImageMailer < ApplicationMailer
  def compression_good(image)
    @image = image
    mail(to: @image.email, subject: "Image has been compressed")
  end

  def compression_bad(image)
    @image = image
    mail(to: @image.email, subject: "Image compression failed")
  end
end
