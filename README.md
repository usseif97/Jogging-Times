# README
# URL:  http://localhost:3000
# rails new jogging_times --api
# bundle install
# rails s
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
```
  POST: /signup    
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
```
  POST: /login
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
```
  DELETE: /logout   
  Parameters: Authorization: JWT token
response: {
    "status": 200,
    "message": "Logged out successfully."
}
```    
___

# Users
## Get all users  
```
  GET: /users    
  Parameters: Authorization: JWT token
response: [
    {
        "id": 1,
        "email": "test@test.com",
        "created_at": "2023-07-11T17:15:41.338Z",
        "updated_at": "2023-07-11T17:15:41.338Z",
        "name": "test",
        "jti": "ab83481f-b7be-451a-a317-bc816d14e1e1",
        "role": "user"
    },
    {
        "id": 3,
        "email": "youssef@test.com",
        "created_at": "2023-07-13T21:26:56.216Z",
        "updated_at": "2023-07-13T21:31:23.150Z",
        "name": "youssef",
        "jti": "b8badc47-310b-49d1-9e06-2f5c5eabed12",
        "role": "manager"
    },
    {
        "id": 5,
        "email": "youssefali@test.com",
        "created_at": "2023-07-13T23:26:12.988Z",
        "updated_at": "2023-07-13T23:26:12.988Z",
        "name": "youssefAli",
        "jti": "6496479b-e37d-47af-8fb7-a06c72585dd4",
        "role": "user"
    }
]
```   
  
## Get a user   
```
  GET: /users/:id      
  Parameters: Authorization: JWT token
response:    {
        "id": 1,
        "email": "test@test.com",
        "created_at": "2023-07-11T17:15:41.338Z",
        "updated_at": "2023-07-11T17:15:41.338Z",
        "name": "test",
        "jti": "ab83481f-b7be-451a-a317-bc816d14e1e1",
        "role": "user"
    }
```
  
## Update user    
```
  PUT: /users/:id      
  Parameters: Authorization: JWT token     
  Body: "user":{   
        "email": "admintest@test.com",   
        "password": "adminpassword"   
        }
response:    {
        "id": 1,
        "email": "test@test.com",
        "created_at": "2023-07-11T17:15:41.338Z",
        "updated_at": "2023-07-11T17:15:41.338Z",
        "name": "test",
        "jti": "ab83481f-b7be-451a-a317-bc816d14e1e1",
        "role": "user"
    }
```

## Delete a user      
```
  DELETE: /users/:id      
  Parameters: Authorization: JWT token
response:    {
        "id": 1,
        "email": "test@test.com",
        "created_at": "2023-07-11T17:15:41.338Z",
        "updated_at": "2023-07-11T17:15:41.338Z",
        "name": "test",
        "jti": "ab83481f-b7be-451a-a317-bc816d14e1e1",
        "role": "user"
    }      
```

## Make a user manager    
```
  PUT: /users/role/manager       
  Parameters: Authorization: JWT token
response:    {
        "id": 1,
        "email": "test@test.com",
        "created_at": "2023-07-11T17:15:41.338Z",
        "updated_at": "2023-07-11T17:15:41.338Z",
        "name": "test",
        "jti": "ab83481f-b7be-451a-a317-bc816d14e1e1",
        "role": "manager"
    }     
```

## Make a user admin    
```
  PUT: /users/role/admin    
  Parameters: Authorization: JWT token
response:    {
        "id": 1,
        "email": "test@test.com",
        "created_at": "2023-07-11T17:15:41.338Z",
        "updated_at": "2023-07-11T17:15:41.338Z",
        "name": "test",
        "jti": "ab83481f-b7be-451a-a317-bc816d14e1e1",
        "role": "admin"
    }
```
___

# Jogs
## Get all jogs  
```
  GET: /jogs
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
```
  GET: /users/:id
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
```
  POST: /users/   
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
```
  PUT: /jogs/:id
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
```
  DELETE: /jogs/:id
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
```
  GET: /jogs/average_distance
  Parameters: Authorization: JWT token
Response: {
    "2023-07-09": 28,
    "2023-07-16": 20
}
```

## Get average speed per week  
```
  GET: /jogs/average_speed
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
```
  POST: /jogs/filter
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
![1](https://github.com/usseif97/Jogging-Times/assets/47598030/75deda15-ea90-4195-8e21-aaf752cbc39f)  

![2](https://github.com/usseif97/Jogging-Times/assets/47598030/a31718ac-4d25-404d-ab3e-4cd1db974775)   

![3](https://github.com/usseif97/Jogging-Times/assets/47598030/9c1557c6-e24e-4889-8448-3f2d25f41046)    

![4](https://github.com/usseif97/Jogging-Times/assets/47598030/0229bf4b-52e1-4090-b385-5a598186bee5)    

![5](https://github.com/usseif97/Jogging-Times/assets/47598030/6b92fe6e-41a5-445e-944c-4290b12a68e6)    

![6](https://github.com/usseif97/Jogging-Times/assets/47598030/093908b1-47b9-46c5-985f-0641c6dcce78)    

![7](https://github.com/usseif97/Jogging-Times/assets/47598030/28810ea2-5447-4752-b9c0-4299be7af655)     

![8](https://github.com/usseif97/Jogging-Times/assets/47598030/f6fa6c8f-6f7b-4f44-938d-f4cd3c22ccc7)    

![9](https://github.com/usseif97/Jogging-Times/assets/47598030/ba7837d3-4591-4d92-866f-fa50a6309c10)    

![10](https://github.com/usseif97/Jogging-Times/assets/47598030/c45bbd7f-13a8-44ab-b5b9-7662a54de636)   

# promote to Admin
![11](https://github.com/usseif97/Jogging-Times/assets/47598030/cbc4002d-8432-4efe-aaea-66b04ed5212d)     

![12](https://github.com/usseif97/Jogging-Times/assets/47598030/956e3c34-1972-4989-a97b-995a2c5196a0)   

    


 

