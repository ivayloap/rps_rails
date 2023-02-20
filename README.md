# README

## Description

Ruby on rails implementation for the 'Rock paper scissors' game, with additional rule of 'Hammer'.
Hammer beats paper and scissors, but looses to rock.
The server bet is taken from https://rolz.org/api/?1d4.json, which returns values between 1 and 4. But in case the call to that endpoint fails, a fallback call is done from the internal LocalGenerator, which will generate one of the 4 RPS possibilities.

* Ruby version
2.7.5

## Installation
  - install ruby version 2.7.5 either with rvm or rbenv.
  - gem install bundler
  - run `bundler install`

## Running the project
start the project by running `rails server`, this will start it on `http://localhost:3000`
