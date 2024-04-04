ActiveAdmin.register ProductCategory do
  permit_params :product_id, :category_id, :description, :price, :quantity, :image, :on_sale, :product_name

  index do
    selectable_column
    id_column
    column :product_name
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
    column :on_sale
    column :created_at
    actions
  end


  form do |f|
    f.inputs 'Product Category Details' do
      # If ProductCategory has product_id, use it to find and set the product.
      # Otherwise, the field will be blank ready for a new association.
      f.input :product_name, as: :string, input_html: { value: f.object.product&.name }
      f.input :category, as: :select, collection: Category.pluck(:name, :id), include_blank: 'None'
      f.input :description
      f.input :price
      f.input :quantity
      f.input :on_sale
      f.input :image, as: :file, input_html: { id: 'image-upload' }
    end
    f.actions
  end

  filter :product
  filter :category
  filter :price
  filter :description
  filter :on_sale

  show do
    attributes_table do
      row :product
      row :category
      row :description
      row :price
      row :quantity
      row :on_sale
      row :created_at
      row :image do |product_category|
        if product_category.image.attached?
          # Specify size
          image_tag url_for(product_category.image), size: '50x50'
        else
          'No image available'
        end
      end
    end
    active_admin_comments
  end

  controller do
    before_action :set_product, only: [:create, :update]

    def create
      @product_category = ProductCategory.new(permitted_params[:product_category])
      @product_category.product = @product
      super
    end

    def update
      super do |success, failure|
        success.html { redirect_to admin_product_category_path(resource) } if resource.valid?
      end
    end

    private

    def set_product
      product_name = params[:product_category][:product_name]
      if product_name.present?
        @product = Product.find_or_create_by(name: product_name)
        params[:product_category][:product_id] = @product.id # Assign the found or created product's ID
      end
    end
  end
end
