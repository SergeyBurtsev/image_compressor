require "test_helper"

class CompressionJobTest < ActiveJob::TestCase
  test "perform image" do
    image = images(:good)

    compression_service_mock = Minitest::Mock.new
    compression_service_mock.expect :call, Proc.new {}, [image]

    CompressionService.stub :new, compression_service_mock do
      CompressionJob.perform_now(image.id)
    end

    compression_service_mock.verify
  end

  test "perform image not found" do
    compression_service_mock = Minitest::Mock.new

    CompressionService.stub :new, compression_service_mock do
      CompressionJob.perform_now("not-found-image")
    end
  end
end
