# Teasub

![ruby](https://img.shields.io/badge/Ruby-2.7.4-red)
![rails](https://img.shields.io/badge/Rails-5.2.7-red)
![rspec](https://img.shields.io/badge/RSpec-3.11.0-green)
![contributors](https://img.shields.io/badge/Contributors-1-yellow)

## Table of Contents
- [Background](#background)
- [Schema](#schema)
- [Learning Goals](#learning-goals)
- [Endpoints](#endpoints)
- [External API Endpoints](#external-api-endpoints)
- [Installation](#installation)
- [Contributor](#contributor)



## Background

TeaSub is a service-oriented Application that exposes API endpoints for tea subscription. This app allows users to view all of their subcriptions, create a new subscription, as well as cancel or reactivate an existing subscription. 

<p align="right">(<a href="#top">back to top</a>)</p>

## Learning Goals

- Make sensible design decisions 
- Efficient error Handling
- Implement interactor as a design pattern

<p align="right">(<a href="#top">back to top</a>)</p>

## Schema

![image](https://user-images.githubusercontent.com/97060659/183128057-32ad44db-2c28-4b08-833e-9819a876026d.png)

<p align="right">(<a href="#top">back to top</a>)</p>

## Endpoints

### Create a subscription
* http request
```
POST http://localhost:3000/subscriptions
Content-Type: application/json
Accept: application/json
headers: { 'Authorization' => 'Bearer YOUR_API_KEY' }
body: {
        "subscription_type": 0,
        "customer_id" :1
      }
```
* Response:

```
{
    "data": {
        "id": "4",
        "type": "subscription",
        "attributes": {
            "title": "QTea",
            "price": 14.99,
            "frequency": "monthly",
            "status": "active",
            "customer_id": 1
        },
        "relationships": {
            "tea": {
                "data": [
                    {
                        "id": "8",
                        "type": "tea"
                    }
                ]
            }
        }
```

<p align="right">(<a href="#top">back to top</a>)</p>

### Update a subscription (cancel or reactivate)
* http request
```
PUT http://localhost:3000/subscriptions
Content-Type: application/json
Accept: application/json
headers: { 'Authorization' => 'Bearer YOUR_API_KEY' }
body: {
        "subscription_id": 2,
        "new_status" : "reactivate"
      }
```
* Response
```
{
    "data": {
        "id": "2",
        "type": "subscription",
        "attributes": {
            "title": "plenTea",
            "price": 19.99,
            "frequency": "bi-weekly",
            "status": "active",
            "customer_id": 1
        },
        "relationships": {
            "tea": {
                "data": [
                    {
                        "id": "2",
                        "type": "tea"
                    },
                    {
                        "id": "3",
                        "type": "tea"
                    }
                ]
            }
        }
    }
}
```
<p align="right">(<a href="#top">back to top</a>)</p>

### Get all subscriptions of a user
* http request
```
GET http://localhost:3000/customers/1/subscriptions
Content-Type: application/json
Accept: application/json
```
* Response
```
{
    "data": [
        {
            "id": "1",
            "type": "subscription",
            "attributes": {
                "title": "QTea",
                "price": 14.99,
                "frequency": "monthly",
                "status": "cancelled",
                "customer_id": 1
            },
            "relationships": {
                "tea": {
                    "data": [
                        {
                            "id": "1",
                            "type": "tea"
                        }
                    ]
                }
            }
        },
        {
            "id": "2",
            "type": "subscription",
            "attributes": {
                "title": "plenTea",
                "price": 19.99,
                "frequency": "bi-weekly",
                "status": "active",
                "customer_id": 1
            },
            "relationships": {
                "tea": {
                    "data": [
                        {
                            "id": "2",
                            "type": "tea"
                        },
                        {
                            "id": "3",
                            "type": "tea"
                        }
                    ]
                }
            }
        },
        {
            "id": "3",
            "type": "subscription",
            "attributes": {
                "title": "thirsTea",
                "price": 24.99,
                "frequency": "weekly",
                "status": "active",
                "customer_id": 1
            },
            "relationships": {
                "tea": {
                    "data": [
                        {
                            "id": "4",
                            "type": "tea"
                        },
                        {
                            "id": "5",
                            "type": "tea"
                        },
                        {
                            "id": "6",
                            "type": "tea"
                        },
                        {
                            "id": "7",
                            "type": "tea"
                        }
                    ]
                }
            }
        },
        {
            "id": "4",
            "type": "subscription",
            "attributes": {
                "title": "QTea",
                "price": 14.99,
                "frequency": "monthly",
                "status": "active",
                "customer_id": 1
            },
            "relationships": {
                "tea": {
                    "data": [
                        {
                            "id": "8",
                            "type": "tea"
                        }
                    ]
                }
            }
        }
    ]
}
```

<p align="right">(<a href="#top">back to top</a>)</p>


## External API Endpoints 

#### Tea API
-  Endpoint(s) consumed:
    * [Tea API](https://github.com/victoria-lo/TAPI)
- Instruction to obtain an API key - no authentication required:
    *  The following endpoint provides 12 types of tea:
    ```
    GET https://tea-api-vic-lo.herokuapp.com/tea
    ```

<p align="right">(<a href="#top">back to top</a>)</p>

## Installation

1. Fork and/or Clone the repo 
  ```
  git clone git@github.com:kg-byte/teasub.git
  ```
2. Install gems and dependencies
  ```
   bundle install
  ```
3. Create database and run migrations
  ```
rails db:create
rails db:migrate
```

4. Run run test suit 
  ```
  bundle exec rspec
  ```
5. Start the local server to service API requests:
  ```
  rails s
  ```
6. Sample testing coverage:
```
teasub:main $ ber
....................................

Finished in 2.6 seconds (files took 1.77 seconds to load)
36 examples, 0 failures

Coverage report generated for RSpec to /Users/xiaoleguo/kg_byte/turing/4module/projects/teasub/coverage. 340 / 340 LOC (100.0%) covered.
```


<p align="right">(<a href="#top">back to top</a>)</p>

## Contributor

### Kim Guo 
[<img src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white" />](https://github.com/kg-byte) &#124; [<img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" />](https://www.linkedin.com/in/kim-guo-5331b4158/)

<p align="right">(<a href="#top">back to top</a>)</p>
