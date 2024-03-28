module ProductCategoriesHelper
  def breadcrumbs(*crumbs)
    content_tag :nav, aria: { label: 'breadcrumb' } do
      content_tag :ol, class: 'breadcrumb' do
        crumbs.map do |text, path|
          class_name = path.nil? ? 'breadcrumb-item active' : 'breadcrumb-item'
          link_or_text = path.nil? ? text : link_to(text, path)
          concat content_tag(:li, link_or_text, class: class_name)
        end
      end
    end
  end
end
