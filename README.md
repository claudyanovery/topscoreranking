# README

- Ruby version `2.7.2`

- MySQL version `5.7`

## System dependencies
- gem 'dotenv-rails'
- gem 'will_paginate'
- gem 'api-pagination'

## Project Setup

### Database initialization

* Run `rails db:create db:migrate db:seed`

### Rails

* Rename `example.env` file to `.env` then fill in the database `password`, `user` and `host`

## How to run the test suite

Coming soon

## API Routes

### Create score 
- Method: POST
- URL: http://localhost:3000/api/v1/scores
- Content type: JSON
- Parameters:
  - Fields: 
    - score: integer 
    - player: string
  - Response:
    ```
    {
        "id": 10,
        "player": "PETER",
        "score": 5,
        "created_at": "2021-11-10T07:41:56.134Z",
        "updated_at": "2021-11-10T07:41:56.134Z"
    }
    ```

### Get score by ID
- Method: GET
- URL: http://localhost:3000/api/v1/scores/:id
- Parameters:
  - id: integer
- Response:
```
{
  "id": 1,
  "player": "Peter",
  "score": 4,
  "created_at": "2021-11-09T14:00:05.534Z",
  "updated_at": "2021-11-09T14:00:05.534Z"
}
```

### Delete score
- Method: DELETE
- URL: http://localhost:3000/api/v1/scores/:id
- Parameters:
    - id: integer
- Response:
```
{
  "message": "Score succesfully deleted."
}
```

### Get list of scores
- Purpose: Get list of scores filtered by `scores.created_at` and `scores.player`
- Method: POST
- Content type: JSON
- URL:
  - Set number of data to show per page
    - http://localhost:3000/api/v1/filter_score?per_page=1&page=1
    - *Default number of data is 30*
- Parameters:
  - Fields:
    - after: datetime (%Y-%m-%d %H:%M:%S)
      - Can send request either with just date or time
    - before: datetime (%Y-%m-%d %H:%M:%S)
      - Can send request either with just date or time
    - players: `string` or `array`
- Response:
```
    [
        {
            "id": 1,
            "player": "Peter",
            "score": 4,
            "created_at": "2021-11-09T14:00:05.534Z",
            "updated_at": "2021-11-09T14:00:05.534Z"
        }
    ]
```

## Get player history
- Purpose: Get the history of a player filtered by `score.player`
- Method: POST
- URL: http://localhost:3000/api/v1/player_history
- Parameters:
  - Type: JSON
  - Fields:
    - player: `string`
- Response:
```
{
  "max_score": 5,
  "low_score": 1,
  "avg_score": 3.25,
  "all_scores": [
    {
      "id": 1,
      "player": "Peter",
      "score": 4,
      "created_at": "2021-11-09T14:00:05.534Z",
      "updated_at": "2021-11-09T14:00:05.534Z"
    },
    {
      "id": 4,
      "player": "peter",
      "score": 1,
      "created_at": "2021-11-09T14:00:05.551Z",
      "updated_at": "2021-11-09T14:00:05.551Z"
    }
  ]
}
```