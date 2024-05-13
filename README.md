# README

## Dependencies
* Ruby version : 3.3.0
* Rails Version : 7.1.3.2
* Postgresql : 12.18

## Setup and start the applicaton

### Change config/database.yml postgres username and password

### Install Dependencies
```
$ gem install bundler && bundle install
```

### Setup database
```
$ rake db:create db:migrate && rake db:seed
```

### Run the server
```
$ rails s
```

### Run the Test Suit
```
$ rspec
```

### Run the rubocop
```
$ rubocop
```
