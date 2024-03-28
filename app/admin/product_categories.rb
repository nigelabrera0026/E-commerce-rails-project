ActiveAdmin.register ProductCategory do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :product_id, :category_id, :description, :price, :quantity
  #
  # or
  #
  # permit_params do
  #   permitted = [:product_id, :category_id, :description, :price, :quantity]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  permit_params :product_id, :category_id, :description, :price, :quantity, :image

  index do
    selectable_column
    id_column
    column :product
    column :category
    column :description
    column :price
    column :quantity
    column :created_at
    column "Image" do |product_category|
      if product_category.image.attached?
        image_tag product_category.image, width: '50' # Adjust the width as needed
      else
        "No image available"
      end
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :product
      f.input :category
      f.input :description
      f.input :price
      f.input :quantity
      f.input :image, as: :file
    end
    f.actions
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs          # builds an input field for every attribute

    f.inputs do
      f.input :image, as: :file, hint: f.object.image.attached? ? image_tag(f.object.image) : content_tag(:span, "No image attached yet")
    end

    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end

  filter :product
  filter :category
  filter :price
  filter :description

end
