require 'spec_helper'

describe "User pages" do
  subject { page }

  describe "Signup page" do
    before { visit signup_path }
    it { should have_selector('h1', text: 'Sign up' )}

    describe "signup" do

      describe "with invalid information" do
        it "should not create a user" do
          expect { click_button "Sign up" }.not_to change(User, :count)
        end

        describe "error messages" do 
          before { click_button "Sign up" }
          it { should have_selector('title', :text => 'Sign up')}
          it { should have_content('errors prohibited this user from being saved') }
        end
      end

      describe "with valid information" do
        before do
          fill_in "Name",         with: "Example User"
          fill_in "Email",        with: "user@example.com"
          fill_in "Password",     with: "foobar"
          fill_in "Confirmation", with: "foobar"
        end

        it "should create a user" do
          expect { click_button "Sign up" }.to change(User, :count).by(1)
        end
        
        describe "after saving the user" do
          before { click_button "Sign up" }
          let(:user) { User.find_by_email('user@example.com') }

          it { should have_selector('title', text: user.name) }
          it { should have_selector('div.flash.success', text: 'Welcome') }
          it { should have_link('Sign out', href: signout_path) }
        end
      end
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }

    before { visit user_path(user) }

    it { should have_selector('h1', text: user.name) }
    it { should have_selector('title', text: user.name) }
  end
end
