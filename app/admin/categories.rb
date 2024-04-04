ActiveAdmin.register Category do
  permit_params :name, :product_categories_id

  filter :product_categories_id
  filter :name

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs 'Category Details' do
      f.input :name
      # Add other inputs for fields you want to be editable
    end
    f.actions # Adds the 'Submit' and 'Cancel' buttons
  end
end
