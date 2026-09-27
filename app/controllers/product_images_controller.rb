class ProductImagesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :deleteImage ]

  def deleteImage
    image = ProductImage.find(params[:id])

    unless image.product.user_id == current_user.id
      render json: { error: "Unauthorized" }, status: :unauthorized
      return
    end

    if image.public_id.present?
      Cloudinary::Uploader.destroy(image.public_id)
    end

    image.destroy

    render json: { success: true }
  end
end
