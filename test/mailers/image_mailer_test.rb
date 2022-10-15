require "test_helper"

class ImageMailerTest < ActionMailer::TestCase
  test "compression_success" do
    image = images(:compressed)
    email = ImageMailer.compression_good(image)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [image.email], email.to
    assert email.subject =~ /compressed/
    assert email.body =~ %r[\/images\/#{image.id}\/download]
  end

  test "compression_failed" do
    image = images(:bad)
    email = ImageMailer.compression_bad(image)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [image.email], email.to
    assert email.subject =~ /failed/
    assert email.body =~ /failed/
  end
end
