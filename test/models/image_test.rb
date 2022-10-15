require "test_helper"

class ImageTest < ActiveSupport::TestCase
  test "has valid fixtures" do
    %i[ good bad ].each do |key|
      image = images(key)
      image.valid?
      assert_empty image.errors
    end
  end

  test "email should be valid" do
    image = Image.new

    [
      "one@example.com",
      "1@abc.co.uk",
    ].each do |valid_email|
      image.email = valid_email
      image.valid?
      assert image.errors[:email].blank?
    end

    [
      "example.com",
      "@abc.co.uk",
    ].each do |invalid_email|
      image.email = invalid_email
      image.valid?
      assert image.errors[:email].present?
    end
  end

  test "compress?" do
    ActiveStorage::Current.url_options = { host: "https://example.com" }
    assert images(:good).compress?
    assert_not images(:bad).compress?
  end
end
