class ImagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
        CompressionJob.perform_later(@image.id)

        format.html
        format.json { head :ok }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { head :unprocessable_entity }
      end
    end
  end

  def download
    @image = Image.find(params[:image_id])
    redirect_to rails_blob_path(@image.image_file.variant(:compressed), disposition: "attachment")
  end

  private
    def image_params
      params.slice(:email, :image_file).permit(:email, :image_file)
    end
end
