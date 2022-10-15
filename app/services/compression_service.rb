class CompressionService
  attr_reader :image

  def initialize(image)
    @image = image
  end

  def call
    if image.compress
      ImageMailer.compression_good(image).deliver_now
    else
      ImageMailer.compression_bad(image).deliver_now
    end
  end
end