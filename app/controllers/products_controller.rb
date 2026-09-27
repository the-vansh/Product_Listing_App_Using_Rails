class ProductsController < ApplicationController
  def showAll
    @products = Product.includes(:product_images).all
  end

  def addProduct
    @product = Product.new
  end

  def createProduct
    @product = Product.new(product_params)

    @product.user = current_user

    if @product.save

      if params[:product][:images].present?

        params[:product][:images].each do |image|
          next if image.blank?

          uploaded_image = Cloudinary::Uploader.upload(
            image.tempfile.path
          )

          @product.product_images.create(
            image_url: uploaded_image["secure_url"],
            public_id: uploaded_image["public_id"]
          )
        end
      end

      redirect_to "/products"

    else
      render :addProduct, status: :unprocessable_entity
    end
  end

  def deleteProduct
    product = Product.find(params[:id])

    unless product.user_id == current_user.id
      render plain: "Unauthorized", status: :unauthorized
      return
    end

    product.product_images.each do |image|
      if image.public_id.present?
        Cloudinary::Uploader.destroy(image.public_id)
      end
    end

    product.destroy

    redirect_to "/products"
  end

  def edit
    @product = Product.find(params[:id])

    unless @product.user_id == current_user.id
      render plain: "Unauthorized", status: :unauthorized
      nil
    end
  end

  def update
     @product = Product.find(params[:id])

    unless @product.user_id == current_user.id
      render plain: "Unauthorized", status: :unauthorized
      return
    end

    if @product.update(product_params)

      if params[:product][:images].present?

        params[:product][:images].each do |image|
          next if image.blank?

          uploaded_image = Cloudinary::Uploader.upload(
            image.tempfile.path
          )

          @product.product_images.create(
            image_url: uploaded_image["secure_url"],
            public_id: uploaded_image["public_id"]
          )
        end

      end

      redirect_to "/products"

    else

      render :edit, status: :unprocessable_entity

    end
  end

  private

  private

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :price,
      :quantity
    )
  end
end
