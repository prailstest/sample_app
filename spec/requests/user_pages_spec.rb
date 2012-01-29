require 'spec_helper'

describe "User pges" do
  subject { page }

  describe "Signup page"
    before { visit signup_path }
    it { should have_selector('h1', text: 'Sign Up' )}
end
