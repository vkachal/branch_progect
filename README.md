 - Info:

I used SitePrism that gives you a simple, clean and semantic DSL
for describing your site using the Page Object Model pattern, and it doesn't limit
you when locate an element by any values when use Watir or Selenium (cheezy does have those limitation):
    - https://github.com/natritmeyer/site_prism

In order to use your current ruby version, I didn't lock specific ruby version for the framework,
so if you have any issue with bundle install, please use ruby-2.2.3.

Requirements:
 - installed Ruby(2.2.3) or any other Ruby version should also works
 - installed chromedriver
 - installed Chrome browser

 How to run test:
 - navigate to the branch_project folder
 - install bundler (gem install bundler)
 - install all ruby gems (bundle install)
 - run tests: bundle exec rspec

 Expected result:
 Finished in ** seconds (files took ** seconds to load)
 1 example, 0 failures
