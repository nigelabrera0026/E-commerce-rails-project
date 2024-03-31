class PagesController < ApplicationController
  def about
    @page_content = PageContent.find_by(page_name: 'about')
  end

  def contact
    @page_content = PageContent.find_by(page_name: 'contact')
  end
end
