require "test_helper"

class CompressionServiceTest < ActiveSupport::TestCase
  test "call on good image" do
    image_mock = Minitest::Mock.new
    image_mock.expect :compress, true

    mailer_mock = Minitest::Mock.new
    mailer_mock.expect :deliver_now, nil

    compession_service = CompressionService.new(image_mock)
    ImageMailer.stub :compression_good, mailer_mock do
      compession_service.call
    end

    mailer_mock.verify
  end

  test "call on bad image" do
    image_mock = Minitest::Mock.new
    image_mock.expect :compress, false

    mailer_mock = Minitest::Mock.new
    mailer_mock.expect :deliver_now, nil

    compession_service = CompressionService.new(image_mock)
    ImageMailer.stub :compression_bad, mailer_mock do
      compession_service.call
    end

    mailer_mock.verify
  end
end
