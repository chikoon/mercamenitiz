# MercAmenitiz
Shopping cart CLI app written by Mike Blake as a tech challenge.

## Requirements
You are the developer in charge of building a cash register.
This app will be able to add products to a cart and compute the total price.

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Code Structure](#code-structure)
- [Dependencies](#dependencies)
- [How to Run Tests](#how-to-run-tests)
- [Contact Author](#contact-author)

## Installation
1. Download the code from github: https://github.com/chikoon/mercamenitiz
2. Install required dependencies using 

       bundle install

## Usage
1. Execute the main script at the root of the project directory.

       ruby ./mercamenitiz.rb

2. Follow the on-screen instructions:

          [P] List products
          [O] List available offers
          [A] Add item to cart
          [R] Remove item from cart
          [C] Show cart contents
          [X] Checkout
          [Q] Quit
          [H] Show this help

## Code Structure
- `lib`:  main application logic.
- `spec`: automated tests

## Dependencies
- Ruby 3.1.2
- RSpec for testing
- Byebug for debugging (development-only)

## How to Run Tests
Execute the following command in the project directory:
    `rspec spec`

## Contact Author
For questions or feedback
Mike Blake
- Email: mike@chikoon.com
- Phone: +34 652 927 813
