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
    column "Image" do |product_category|
      if product_category.image.attached?
        image_tag url_for(product_category.image), size: '50x50'
      else
        'No image available'
      end
    end
    actions
  end

  form do |f|
    f.inputs 'Product Category Details' do
      f.input :product, as: :select, collection: Product.pluck(:name, :id)
      f.input :category, as: :select, collection: Category.pluck(:name, :id)
      f.input :description
      f.input :price
      f.input :quantity
      f.input :image, as: :file, hint: f.object.image.attached? ? image_tag(url_for(f.object.image), size: '50x50') : content_tag(:span, 'No image available')
    end
    f.actions
  end

  filter :product
  filter :category
  filter :price
  filter :description

  show do
    attributes_table do
      row :product
      row :category
      row :description
      row :price
      row :quantity
      row :image do |product_category|
        if product_category.image.attached?
          image_tag url_for(product_category.image), size: '50x50'
        else
          'No image available'
        end
      end
    end
    active_admin_comments
  end
end
