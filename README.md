![Build Status][build-badger]
[![Maintainability][maitainability-badger]][codeclimate]
[![Test Coverage][test-coverage]][testcoveragelink]

<p align="center">
  <img src="frontend/public/img/icons/apple-touch-icon.png" alt="Logo" width="80" height="80">
  <h3 align="center"><b>Bets Accounting</b></h3>
  <h6 align="center"><i>Work in progress</i></h6>
</p>

# Getting Started

## Prerequisites
To start development server you need latest stable versions of `git`, `docker`,
`docker-compose` and [dip](https://github.com/bibendi/dip) installed.

## How to start
1. Clone the repository ⬇️ `git clone git@github.com:Mayurifag/bets_accounting.git`
2. Enter project directory 📁 `cd bets_accounting`
3. Leave the rest of things to dip 😎 `dip provision`

## Entrypoints
* Frontend: [localhost:3333](http://localhost:3333)
* Backend: [localhost:8888](http://localhost:8888)

# Tests

## Rspec

Just use `dip rspec` to launch `rspec` and get the spec coverage from
simplecov.

## Parallel tests

If you want to use all the cores of your CPU for specs, you may use these
commands:

* `RAILS_ENV=test dip rake parallel:setup`
* `dip spec`

[build-badger]: https://github.com/Mayurifag/bets_accounting/workflows/Main/badge.svg
[maitainability-badger]: https://api.codeclimate.com/v1/badges/1d95ce316920a6a8228b/maintainability
[codeclimate]: https://codeclimate.com/github/Mayurifag/bets_accounting/maintainability
[test-coverage]: https://api.codeclimate.com/v1/badges/1d95ce316920a6a8228b/test_coverage
[testcoveragelink]: https://codeclimate.com/github/Mayurifag/bets_accounting/test_coverage
