# PivotalTracker

Pivotal Tracker Wrapper to Work with V5 endpoints, using VCR as request testing and ActiveModel for validations

## Installation

Add this line to your application's Gemfile:

    gem 'pivotal-tracker-wrapper'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pivotal-tracker-wrapper

## Usage

TODO: Write usage instructions here

### Tests

To run the tests for the first time you have to have internet connection and configured the following environment variables:

1. PIVOTAL_NAME
2. PIVOTAL_USERNAME
3. PIVOTAL_PROJECT_ID
4. PIVOTAL_PASSWORD

This is because I don't want to leave my credentials open to everyone.
Running the tests once will create a bunch of files inside spec folder (that has been ignored in gitignore) with the response. After this, the requests won't be made to the server but rather will get the answers from the files (thanks to VCR gem).

## Contributing

1. Fork it ( http://github.com/<my-github-username>/pivotal-tracker-wrapper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
