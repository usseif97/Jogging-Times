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
  
# Third party libraries
ruby "3.2.2"       
gem "rails", "~> 7.0.6"        
gem "sqlite3", "~> 1.4"      
gem 'devise'       
gem 'devise-jwt'           
gem 'jsonapi-serializer'          
gem "groupdate"         

# Authentication
  * devise  
     - Signup, implemented through devise registrations controller  
     - login & logout, implemented through devise sessions controller
  * devise-jwt
      - handle token dispatch and authentication    

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
         
# Jog    
  * attributes      
      - date        
      - distance "Km"       
      - time "hr"    
      - user_id, foreign key that reference to User "belongs_to"   
   
# API endpoints   

# Registartion
## Signup
  POST: /signup    
    ```
  Body: "user":{   
        "email": "admintest@test.com",   
        "password": "adminpassword",   
        "name": "admintest"   
        }   
  header:  JWT token    
Response: {
    "status": {
        "code": 200,
        "message": "Signed up successfully."
    },
    "data": {
        "id": 5,
        "email": "youssefali@test.com",
        "name": "youssefAli",
        "role": "user"
    }
}
```
   
  
## Login   
  POST: /login
  ```
  Body: "user":{   
        "email": "admintest@test.com",    
        "password": "adminpassword"   
        }   
  header:  JWT token    
Response: {
    "status": {
        "code": 200,
        "message": "Signed up successfully."
    },
    "data": {
        "id": 5,
        "email": "youssefali@test.com",
        "name": "youssefAli",
        "role": "user"
    }
}
```

## Logout
  DELETE: /logout   
  Parameters: Authorization: JWT token     
___

# Users
## Get all users  
  GET: /users    
  Parameters: Authorization: JWT token     
  
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

# Jogs
## Get all jogs  
  GET: /jogs
  ```
  Parameters: Authorization: JWT token     
Response:[
    {
        "id": 11,
        "date": "2023-07-14",
        "distance": 14,
        "time": 3,
        "user_id": 5,
        "created_at": "2023-07-13T23:29:07.787Z",
        "updated_at": "2023-07-13T23:29:07.787Z"
    },
    {
        "id": 12,
        "date": "2023-07-14",
        "distance": 13,
        "time": 2,
        "user_id": 5,
        "created_at": "2023-07-13T23:29:31.589Z",
        "updated_at": "2023-07-13T23:29:31.589Z"
    }
]
```     

## Get a jog    
  GET: /users/:id
    ```          
  Parameters: Authorization: JWT token  
Response: {
    "id": 11,
    "date": "2023-07-14",
    "distance": 14,
    "time": 3,
    "user_id": 5,
    "created_at": "2023-07-13T23:29:07.787Z",
    "updated_at": "2023-07-13T23:29:07.787Z"
}
```     

## Add  jog    
  POST: /users/   
    ```     
  Parameters: Authorization: JWT token     
  body: {
      "date": "13/7/2023",
      "distance": 8888,
      "time": 8
      }
Response: {
    "id": 13,
    "date": "2023-07-14",
    "distance": 15,
    "time": 6,
    "user_id": 5,
    "created_at": "2023-07-13T23:31:36.767Z",
    "updated_at": "2023-07-13T23:31:36.767Z"
}
```         
## Update jog    
  PUT: /jogs/:id
  ```      
  Parameters: Authorization: JWT token     
  body: {
      "date": "13/7/2023",
      "distance": 8888,
      "time": 8
      }
Response: {
    "user_id": 5,
    "time": 4,
    "id": 11,
    "date": "2023-07-14",
    "distance": 14,
    "created_at": "2023-07-13T23:29:07.787Z",
    "updated_at": "2023-07-13T23:32:25.940Z"
}
```      

## Delete a jog      
  DELETE: /jogs/:id
  ```           
  Parameters: Authorization: JWT token
Response: {
    "id": 11,
    "date": "2023-07-14",
    "distance": 14,
    "time": 4,
    "user_id": 5,
    "created_at": "2023-07-13T23:29:07.787Z",
    "updated_at": "2023-07-13T23:32:25.940Z"
}
```            

## Get average distances per week    
  GET: /jogs/average_distance
  ```       
  Parameters: Authorization: JWT token
Response: {
    "2023-07-09": 28,
    "2023-07-16": 20
}
```      

## Get average speed per week    
  GET: /jogs/average_speed
  ```        
  Parameters: Authorization: JWT token
Response:{
    "distance": {
        "2023-07-09": 28,
        "2023-07-16": 20
    },
    "time": {
        "2023-07-09": 8,
        "2023-07-16": 4
    },
    "speed": [
        3,
        2
    ]
}
```       

## Filter by date    
  POST: /jogs/filter
  ```        
  Parameters: Authorization: JWT token
  body: {
      "from": "13/7/2023",
      "to": "14/7/2023",
      }
Response: [
    {
        "id": 12,
        "date": "2023-07-14",
        "distance": 13,
        "time": 2,
        "user_id": 5,
        "created_at": "2023-07-13T23:29:31.589Z",
        "updated_at": "2023-07-13T23:29:31.589Z"
    },
    {
        "id": 13,
        "date": "2023-07-14",
        "distance": 15,
        "time": 6,
        "user_id": 5,
        "created_at": "2023-07-13T23:31:36.767Z",
        "updated_at": "2023-07-13T23:31:36.767Z"
    }
]
```      
___   

# Examples
![1](https://github.com/usseif97/Jogging-Times/assets/47598030/4954f2cb-bf24-4423-ba91-a597445aee07)    
   
![2](https://github.com/usseif97/Jogging-Times/assets/47598030/0f3d7edd-542f-4cfc-9722-f03cb3e98d36)   
   
![3](https://github.com/usseif97/Jogging-Times/assets/47598030/0c6d3abf-6882-40a7-8cd6-3bf430cb8bee)  
   
![4](https://github.com/usseif97/Jogging-Times/assets/47598030/3c222b4f-1ba8-40bd-888b-b093b8876767)  
   
![5](https://github.com/usseif97/Jogging-Times/assets/47598030/49158ad1-c5ed-48bb-b7c0-f0cd624d7e45)  
   
![6](https://github.com/usseif97/Jogging-Times/assets/47598030/dbf19eaf-0b28-4eef-b895-e60f4e1d3e8a)  
   
![7](https://github.com/usseif97/Jogging-Times/assets/47598030/9e8cb2a3-ead0-46fd-aa3a-c802fe8fae97)  
   
![8](https://github.com/usseif97/Jogging-Times/assets/47598030/914efdc3-aaae-458e-8d67-f3153971e444)    
   
![9](https://github.com/usseif97/Jogging-Times/assets/47598030/d064d923-348e-410b-961b-ee743796ba8d)      
   
![10](https://github.com/usseif97/Jogging-Times/assets/47598030/8bf75157-4abb-4bfe-ad2e-9e69a181bcaf)    

# promote to Admin
![11](https://github.com/usseif97/Jogging-Times/assets/47598030/a0ef82fa-a361-44da-9030-27fe88a3e1f3)   

![12](https://github.com/usseif97/Jogging-Times/assets/47598030/e626b6f3-6c19-4a91-868b-11e078ce2324)       

 

