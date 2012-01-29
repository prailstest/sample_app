require 'spec_helper'

describe "Static pages" do
  describe "Home page" do
    it "should have the content 'Sample App'" do
      visit root_path
      page.should have_selector('h1', :text => 'Sample App')
    end
    it "should have the correct title" do
      visit root_path
      page.should have_selector('title', :text => ' | Home')
    end
  end

  describe "Help page" do
    it "should have the content 'Help'" do
      visit help_path
      page.should have_selector('h1', :text => 'Help')
    end
  end

  describe "About page" do
    it "should have the content 'About'" do
      visit about_path
      page.should have_selector('h1', :text => 'About')
    end
  end

  describe "Contact page" do
    it "should have the content 'Contact'" do
      visit contact_path
      page.should have_selector('h1', :text => 'Contact')
    end

    it "should have the correct title" do
      visit contact_path
      page.should have_selector('title', :text => '| Contact')
    end
  end
end