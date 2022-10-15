require "test_helper"

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test "get root" do
    get root_url
    assert_response :success
    assert_compress_image_button
  end

  test "post compress html success" do
    assert_difference "Image.count", 1 do
      post compress_images_url, params: {
        email: "one@example.com",
        image_file: fixture_file_upload("good.jpg"),
      }

      assert_response :success
    end

    image = Image.last
    assert_equal "one@example.com", image.email

    assert_select "div", /Image uploaded/
    assert_compression_job_enqueued(image)
  end

  test "post compress json success" do
    assert_difference "Image.count", 1 do
      post compress_images_url, params: {
        email: "one@example.com",
        image_file: fixture_file_upload("good.jpg"),
      }, headers: { Accept: "application/json" }

      assert_response :success
    end

    image = Image.last
    assert_equal "one@example.com", image.email
    assert_compression_job_enqueued(image)
  end

  test "post compress html fail" do
    assert_difference "Image.count", 0 do
      post compress_images_url, params: {
        email: "@example.com",
      }

      assert_response :unprocessable_entity
    end

    assert_compress_image_button
  end

  test "get download success" do
    image = images(:good)
    get image_download_url(image)
    assert_response :redirect
  end

  test "get download not found" do
    assert_raises ActiveRecord::RecordNotFound do
      get image_download_url("non-existed-id")
    end
  end

  private
    def assert_compress_image_button
      assert_select "input[type=submit]", value: /Compress Image/
    end

    def assert_compression_job_enqueued(image)
      assert_enqueued_with job: CompressionJob, args: [image.id]
    end
end
