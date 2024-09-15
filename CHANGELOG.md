# Changelog

All notable changes to this project will be documented in this file.

## 2024-09-13

- Added Nginx: `1.26.2`, `1.27.1`
- Added OS CODE: `alpine3.20`
- Added PHP: `8.4`

## 2024-07-30

- Added Nginx: `1.26.1`, `1.27.0`

## 2024-05-03

- Added Nginx: `1.26.0`, `1.25.5`
- Added OS CODE: `alpine3.19`

## 2024-02-16

- Added Nginx: `1.25.4`

## 2024-02-11

- Added Nginx: `1.25.3`

## 2023-09-09

- Added PHP: `8.3`

## 2023-04-25

- Added PHP: `7.2`
- Added Nginx: `1.22.1`, `1.24.0`
- Added OS CODE: `alpine3.17`
- Modified Docker API call from v1 to v2.

## 2023-06-23

- Added Laravel: `9.1.10`, `8.6.12` (for testing)

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

