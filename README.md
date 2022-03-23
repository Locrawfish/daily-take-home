# Daily Take Home Readme

Hi folks! Thanks for taking a look! This Rails project does a few things based on this [prompt](https://dailyco.notion.site/REST-API-Candidates-video-call-metrics-programming-project-a65f6353e6f04c7c9017cdc9911e33c0), including:

* Create a meeting via Daily
* View Metrics by Room Name
* Get total participant time based on a time period


## How to Run
* Pull down this repo

* Install the dependencies by running `bundle install` in the command line -- you may need to install ruby and bundler to do this. 
    * First check if you have ruby by running `ruby -v`, if you already have ruby installed, then check if you have bundler by running `bundler -v` 
    * If you don't have ruby, my preferred way is to use Brew: `brew install ruby`, however if you don't have brew already installed, there are several other methods you can find in these[directions](https://www.ruby-lang.org/en/documentation/installation/).
    * If you need to install bundler, you can do so by running `gem install bundler`

* Start your server by running ` bin/rails server` in the command line

* Go to `http://localhost:3000` in your browser and take a look around.

* You'll need your API key to create room and access participant data

If you encounter issues, Rails has a lot of documentation. I suggest taking a look at their [Getting Started](https://guides.rubyonrails.org/getting_started.html) documentation first. Hopefully, you won't need this :)

## Run tests
I've only included two tests in this submission. I would add more for production ready code. I showed only a couple of tests, since they were the simpliest unit tests I could do.

### How to Run Tests
In console, run `bin/rails test`
