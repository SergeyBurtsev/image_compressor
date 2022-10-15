class CompressionJob < ApplicationJob
  def perform(image_id)
    image = Image.find_by(id: image_id)
    return unless image

    CompressionService.new(image).call
  end
end
