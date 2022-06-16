# Changelog

All notable changes to this project will be documented in this file.

## 2022-06-15

- Added PHP: `8.2`
- Added Nginx: `1.22.0`, `1.21.6`, `1.20.2`
- Added OS CODE: `bullseye`, `alpine3.16`, `alpine3.15` 
- Workflow changed: Screen out `RC`, `rc`, `alpha`, `beta` PHP versions except the latest major version (e.g. `8.2` for now) during the toolkit process.
- Workflow explained: All the Dockerfiles under the `Dockerfiles/{OS CODE}` folder will not be removed when release new Dockerfiles of new version combinations. It (the workflow definition) may be helpful for people who need those earlier combinations. This project would do the best to maintain built Docker images which listed in the latest `docs/Tags.md` available on the supported image registries.

## 2021-11-03

- Testing with a new OS CODE: `bullseye`

## 2021-08-31

- Added Testing Laravel: `8.6.1`, `8.5.24`

## 2021-08-10

- Added PHP: `8.1`

## 2021-08-05

- Added Testing Laravel: `8.5.23`

## 2021-07-25

- Changed tag naming rule for easier maintanance and searching.

## 2021-06-29

- Added Nginx: `1.20.1`
- Added OS CODE: `alpine3.13` 

## 2021-04-22

- Push images into multiple registries at the same time.

## 2021-01-08

- Added PHP: `8.0`

## 2020-09-22

- Added PHP: `7.4`
- Added OS CODE: `buster`, `alpine3.12` 

## 2020-09-17

- Initial commit.

