# search_analytics_example
An example of a fast search analytics using Rails 5.1 and ReactJS | Example: https://searchanalyticsexample.herokuapp.com/

# Details

This app creates a simple article search which keeps track of the user queries.
Technically, it sets the search key into Redis using the user token (generated in the client browser) and creates a sidekiq job to check after 20 seconds if the key was changed (usually because after that job, the user typed some more chars). If the key is the same or the it doesn't seem to be the same question, The ```SearchAnalytic``` model will score it.
In the view, there's a loop updating the search analytics stats and a button to erase all the analytics.

In db/seeds.rb, there's a random seeder of articles to be searched for.

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
