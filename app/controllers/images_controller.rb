class ImagesController < ApplicationController
  include ActiveStorage::Streaming

  skip_before_action :verify_authenticity_token

  def new
    @image = Image.new(email: session[:email])
  end

  def create
    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
        CompressionJob.perform_later(@image.id)
        session[:email] = @image.email

        format.html
        format.json { head :ok }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def download
    @image = Image.find(params[:image_id])
    send_blob_stream(@image.image_file.variant(:compressed).image.blob, disposition: "attachment")
  end

  private
    def image_params
      params.slice(:email, :image_file).permit(:email, :image_file)
    end
end
