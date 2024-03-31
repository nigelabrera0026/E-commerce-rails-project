class PageContent < ApplicationRecord
  def about
    @page_content = PageContent.find_by(page_name: 'about')
  end

  def contact
    @page_content = PageContent.find_by(page_name: 'contact')
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[title content page_name]
  end
end
