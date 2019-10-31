![Build Status][build-badger]
[![Maintainability][maitainability-badger]][codeclimate-link]
[![Test Coverage][testcoverage-badger]][testcoverage-link]
[![License: LGPL v3][license-badger]][license-link]

<p align="center">
  <img src="frontend/public/img/icons/apple-touch-icon.png" alt="Logo" width="80" height="80">
  <h3 align="center"><b>Bets Accounting</b></h3>
  <h6 align="center"><i>Work in progress</i></h6>
</p>

# Getting Started

## Prerequisites
To start development server you need latest stable versions of `git`, `docker`,
`docker-compose` and [dip][dip-link] installed.

## How to start
1. Clone the repository ⬇️ `git clone git@github.com:Mayurifag/bets_accounting.git`
2. Enter project directory 📁 `cd bets_accounting`
3. Leave the rest of things to dip 😎 `dip provision`

## Entrypoints
* Frontend: [localhost:3333][frontend-localhost]
* Backend: [localhost:8888][backend-localhost]

# Tests

## Rspec

Just use `dip rspec` to launch `rspec` and get the spec coverage from
simplecov.

## Parallel tests for RSpec

If you want to use all the cores of your CPU for API specs, you may use
`make parallel`. Its not profitable due to small number of specs, though.

## Cypress

There are simple end-to-end tests, you may launch them with `make cypress`.

[build-badger]: https://github.com/Mayurifag/bets_accounting/workflows/Main/badge.svg
[maitainability-badger]: https://api.codeclimate.com/v1/badges/1d95ce316920a6a8228b/maintainability
[codeclimate-link]: https://codeclimate.com/github/Mayurifag/bets_accounting/maintainability
[testcoverage-badger]: https://api.codeclimate.com/v1/badges/1d95ce316920a6a8228b/test_coverage
[testcoverage-link]: https://codeclimate.com/github/Mayurifag/bets_accounting/test_coverage
[license-badger]: https://img.shields.io/badge/License-LGPL%20v3-gree.svg
[license-link]: https://www.gnu.org/licenses/lgpl-3.0
[dip-link]: https://github.com/bibendi/dip
[frontend-localhost]: http://localhost:3333
[backend-localhost]: http://localhost:8888
