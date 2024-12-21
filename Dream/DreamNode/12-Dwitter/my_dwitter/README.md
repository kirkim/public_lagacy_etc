# 🚀 Tweets API

## Home ('/')

1. GET
   - if not login redirect `/login`
   - input chat
     1. 'text'
   - chat
2. POST
   - req:
     1. text
     2. name
     3. time
   - res:
     - redirect `/`

## Login ('/login')

1. GET
   - input
     1. 'username'
     2. 'password'
   - create user link `/join`
2. POST
   - req
     1. 'username'
     2. 'password'
   - res
     - `success`: redirect `/`
     - `fail`: get `/login` + "error message"

## Join ('/join)

1. GET
   - input
     1. 'username'
     2. 'name'
     3. 'address'
     4. 'password'
     5. 'confirm password'
2. POST
   - req
     1. 'username'
     2. 'name'
     3. 'address'
     4. 'password'
     5. 'confirm password'
   - res
     - `fail`(username already exist)
       - get `/join` + "error message"
     - `success`
       - redirect `/login`
