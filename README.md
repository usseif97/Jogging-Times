# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# Authentication
  * devise  
     - Signup, implemented through devise registrations controller  
     - login & logout, implemented through devise sessions controller
  * devise-jwt
      - handle token dispatch and authentication
      - the token expires after 60 minutes 
    

# User
  * attributes   
      - name   
      - email   
      - password   
      - role, user - manager - admin where each one have appropriate permissions   
      - jti, used to store the access token of the userto make sure it doesn't end up in the wrong hands         

    * user: CRUD his own jogs     
    * manager: CRUD users   
    * admin: CRUD all jogs, CRUD users, CRUD managers   
   
# API endpoints
# Registartion
## Signup
  POST: /signup            
  Body: "user":{   
        "email": "admintest@test.com",   
        "password": "adminpassword",   
        "name": "admintest"   
        }   
  Response: JWT token    
  
## Login   
  POST: /login     
  Body: "user":{   
        "email": "admintest@test.com",    
        "password": "adminpassword"   
        }   
  Response: JWT token   

## Logout
  DELETE: /logout   
  Parameters: Authorization: JWT token     
___

# Users
## Get all users  
  GET: /users    
  Parameters: Authorization: JWT token     
  Response: JWT token   
  
## Get a user    
  GET: /users/:id      
  Parameters: Authorization: JWT token       
  
## Update user    
  PUT: /users/:id      
  Parameters: Authorization: JWT token     
  Body: "user":{   
        "email": "admintest@test.com",   
        "password": "adminpassword"   
        }   

## Delete a user      
  DELETE: /users/:id      
  Parameters: Authorization: JWT token        

## Make a user manager    
  GET: /users/role/manager       
  Parameters: Authorization: JWT token       

## Make a user admin    
  GET: /users/role/admin    
  Parameters: Authorization: JWT token      
___
