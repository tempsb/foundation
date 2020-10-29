# README

To start the service, from a terminal run:
`
./containers_script.sh
`

Then from the prompt select
`Start Containers`

Before the various containers start, the packages and builds will first compile, and the migrations will be executed.

----

Main URL:
* http://localhost:8080

To connect directly to the API-Gateway:
* http://localhost:3000
* http://localhost:3000/api/orders (sample API endpoint)


To connect directly to the Product Service:
* http://localhost:9000
* http://localhost:9000/api/orders (sample API endpoint)

----

### Tests

To run the php tests, from a terminal window within the product directory:
`./vendor/bin/phpunit`
