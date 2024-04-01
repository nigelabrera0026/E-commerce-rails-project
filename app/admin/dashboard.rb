# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    section "Recent Product Categories" do
      table_for ProductCategory.order("created_at desc").limit(5) do
        column "Image" do |product_category|
          if product_category.image.attached?
            image_tag product_category.image, width: '50', heigth: '50'
          else
            "No image available"
          end
        end
        column :product
        column :category
        column :price
        column :created_at
        column "" do |product_category|
          links = []
          links << link_to('View', admin_product_category_path(product_category), class: 'member_link')
          links << link_to('Edit', edit_admin_product_category_path(product_category), class: 'member_link')
          links << link_to('Delete', admin_product_category_path(product_category), method: :delete, data: {
            confirm: 'Are you sure you want to delete this?'
            }, class: 'member_link delete_link')
          links.join(' ').html_safe
        end
      end
      strong { link_to "View All Product Categories", admin_product_categories_path }
    end
    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end
    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
