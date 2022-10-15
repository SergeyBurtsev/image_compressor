class CompressionService
  attr_reader :image

  def initialize(image)
    @image = image
  end

  def call
    email = if image.compress?
      ImageMailer.compression_good(image)
    else
      ImageMailer.compression_bad(image)
    end

    email.deliver_now
  end
end