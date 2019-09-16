# README is going to be be rewritten!

## Description
This repository is yet another pet project, where I'm practicing with **Vue.js** & **Rails**.

Application is requested by my friend as a better alternative for his spreadsheet about bets' win/lose statistics.

Project is not production-ready, but is a proof-of-concept. Work is in progress. For example there is a mess with dotenv files and the frontend needs some more checks for blank fields.

## How to launch
**TL;DR:** `dip provision`

Be sure that you installed latest stable `docker` and `docker-compose`.
Project is developed with `docker 18.09.2` and `docker-compose 1.23.2`.

* Clone the repository and enter the directory:
`git clone https://github.com/Mayurifag/bets_accounting.git ; cd bets_accounting`

* (Optional) Maybe there is a WIP branch to use, you may checkout there

* Build development environment: `docker-compose build`

* Launch development environment in detached mode: `docker-compose up -d`

* Seed the database if its the first launch: `docker-compose exec app rails db:setup`

* Application is ready, visit `lvh.me:3000`
