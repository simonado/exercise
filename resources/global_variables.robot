*** Settings ***
Library     collections
Library     requests

*** Variables ***
# base path for api calls
${APIBASEURL}     https://petstore.swagger.io/v2

# rest paths
${PETRESTPATH}    pet
${STORERESTPATH}    store
${USERRESTPATH}    user

# heroku base
${APIBASEURLAUTH}   https://restful-booker.herokuapp.com

# heroku rest
${BOOKINGRESTPATH}    booking
${AUTHRESTPATH}    auth