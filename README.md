# Sherlock

Inventories and sorting for the rest of us. Seriously.

## What is this?
An intuitive (hopefully) inventory application built with Ruby on Rails.

![Screenshot of Sherlock on Safari](readmeassets/screenshot.png "Sherlock")

## Getting Started
- Downloading
    - Clone this repository with git clone: `git clone https://github.com/SumukhPrasad/Sherlock.git`
    - Download and copy WOFF2 fonts for *Inter Display* and *Source Serif 4* in the manner specified by [Fonts.md](./Fonts.MD)
- Setting Up
    - Set up and install dependencies: `bundle install`
    - Set your email address and password for Devise's mailer:
        - `EDITOR=vim rails credentials:edit`
        - Then, copy and fill in the contents of `credentials.yml-template`
    - Migrate the database using `rails db:migrate`
    - Run `rails server` to start up.
