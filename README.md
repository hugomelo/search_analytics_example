# search_analytics_example
An example of a fast search analytics using Rails 5.1 and ReactJS | Example: https://searchanalyticsexample.herokuapp.com/

# Installation
Since this app is a [Rails](http://rubyonrails.org) 5.1 application, you need to run the following after downloading the code:

  1. `$ cd search_analytics_example`
  2. `$ bundler`
  3. `$ bundle exec rake db:create db:migrate`

You may want to load sample data into database:

`$ bundle exec rake db:seed`

#### Starting the server
Install foreman gem using the command: `gem install foreman`.

**You need to set PORT to 3000 before running foreman**

Start all development servers:

`$ foreman start -e .env`

Now, you may visit the following URLs:

* Application Server: http://localhost:3000/
