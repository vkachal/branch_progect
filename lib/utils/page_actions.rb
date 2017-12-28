class PageActions < SitePrism::Page
  # everything that can be shared between page objects can go here...

  include Capybara::DSL

  BranchApp.register_page_object(self)

  def self.inherited(klass)
    BranchApp.register_page_object(klass)
  end

end
