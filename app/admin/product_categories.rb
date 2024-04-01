ActiveAdmin.register ProductCategory do
  permit_params :category_id, :description, :price, :quantity, :image, :product_name

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
      f.input :product_name, as: :string, label: 'Product Name'
      f.input :category, as: :select, collection: Category.pluck(:name, :id)
      f.input :description
      f.input :price
      f.input :quantity
      f.input :image, as: :file, input_html: { id: 'image-upload' }

      # The div for image preview should be here, outside of javascript_tag
      div id: 'image-preview', style: 'margin-top: 20px'
    end
    f.actions

    # JavaScript for image preview
    f.template.javascript_tag do
      <<-JS
        document.addEventListener('DOMContentLoaded', function() {
          var input = document.getElementById('image-upload');
          input.addEventListener('change', function(e) {
            if (input.files && input.files[0]) {
              var reader = new FileReader();
              reader.onload = function(e) {
                var preview = document.getElementById('image-preview');
                preview.innerHTML = ''; // Clear previous images
                var img = new Image();
                img.src = e.target.result;
                img.style.maxWidth = '500px';
                img.style.maxHeight = '500px';
                preview.appendChild(img);
              }
              reader.readAsDataURL(input.files[0]);
            }
          });
        });
      JS
    end
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

  controller do
    before_action :set_product, only: [:create, :update]

    def create
      @product_category = ProductCategory.new(permitted_params[:product_category])
      @product_category.product = @product
      super
    end

    def update
      super do |format|
        redirect_to admin_product_category_path(resource) and return if resource.valid?
      end
    end

    private

    def set_product
      product_name = params[:product_category][:product_name]
      @product = Product.find_or_create_by(name: product_name) if product_name.present?
    end
  end
end
