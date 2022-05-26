# README

Create a RESTful JSON API server

## Version
- Ruby 3.0.2
- Rails 6.1.4.1

## Environments

### Setup Ruby

- Install rbenv
  ```
  $ brew install rbenv ruby-build
  ```

- Install Ruby
  ```
  $ rbenv install 3.0.2
  $ rbenv global 3.0.2
  ```

- Setup bash_profile for rbenv
  ```
  # rbenv
  eval "$(rbenv init -)"
  ```

- Confirm ruby version
  ```
  $ ruby -v
  ruby 3.0.2p107 (2021-07-07 revision 0db68f0233) [x86_64-darwin21]

  $ rbenv global
  3.0.2
  ```

- Install Ruby Bundle
  ```
  $ sudo gem install bundler
  ```

### Install library 
```
git clone
bundle install
```

### Setup Database
```
rails db:create
rails db:migrate
rails db:seed
```

### Run server
```
bin/rails s -p 3003
http://localhost:3003/
```

## Run tests
```
bundle exec rspec
```

## Samples
I created a simple Frontend for creating new user, login, logout and show user's info such as Username, Access Token and Token expire time.

### Home page
![Home Page](/samples/home.png)

### Login Page
![Login Page](/samples/login.png)

### Register Page
![Register Page](/samples/register.png)

### User Page
![User Page](/samples/user_page.png)
