require 'spec_helper'

describe "StaticPages" do

	subject { page }

	describe "Home page" do
		before { visit root_path }

		it { should have_content('TheCodeArchive') }
		it { should have_title('TheCodeArchive') }
		it { should_not have_title(' | Home') }
		it { should have_link('Home') }
		it { should have_link('Help') }
		it { should have_link('Contact') }
	end

	describe "Help page" do
		before { visit help_path }

		it { should have_content('Help') }
		it { should have_title('| Help') }
	end

	describe "Contact page" do
		before { visit contact_path }

		it { should have_content('Contact') }
		it { should have_title('| Contact') }
	end
end
