# HW4: BDD & TDD CYCLE

In this assignment you will use a combination of Behavior-Driven Design (BDD) and Test-Driven Development (TDD) with the Cucumber and RSpec tools to add a "find movies with same director" feature to RottenPotatoes, and deploy the resulting app on Heroku.

Again, you will be building off of previous homeworks, so continue to work in your RottenPotatoes app.

**Please now follow the instructions below to get setup**

1. Change into the rottenpotatoes directory
2. In your Gemfile, add the following lines to your 'test' and 'development' groups:
	* `gem 'rspec-rails', '~> 2.14.0'`
	* `gem 'simplecov'`
1. In your Gemfile, add the following lines to your 'assets' group:
	* `gem 'therubyracer'`
	* `gem 'sass-rails'`
	* `gem 'coffee-rails'`

Run `bundle install --without production` to make sure all gems are properly installed.
Run `bundle exec rake db:migrate` to apply database migrations.
Finally, run this command to set up the RSpec directory (under spec/), allowing overwrite of any existing files: "`rails generate rspec:install`"

You can make sure that RSpec is installed correctly by running "`bundle exec rspec`".  This should have very little output; since you have no RSpec tests yet it should just report that no tests ran.

# Part 1: Add a Director field to Movies

Create and apply a migration that adds the Director field to the movies table. The director field should be a string containing the name of the movie’s director. HINT: use the add_column method of ActiveRecord::Migration to do this, or use a smart migration name to have Rails interpret your migration and build it for you: [http://guides.rubyonrails.org/v3.2.13/migrations.html](http://guides.rubyonrails.org/v3.2.13/migrations.html)

In order for mass assignment to continue working, add :director to the attr_accessible arguments in the movie.rb model.

Remember that once the migration is applied, you also have to do `rake db:test:prepare` to load the new post-migration schema into the test database in addition to `rake db:migrate` for the development database!

	$ rails generate migration AddPartNumberToProducts part_number:string

	class AddPartNumberToProducts < ActiveRecord::Migration
	  def change
	    add_column :products, :part_number, :string
	  end
	end


	$ rails generate migration AddDirectorToMoives director:string

