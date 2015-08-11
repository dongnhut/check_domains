#Rails core service

This is template for api service. This has write by ruby on rails and grape gem.  

##Menu
[TOC]

## Config database
Create new database file on config folder with content. `config/database.yml`
``` ruby
 adapter: mysql2
  encoding: utf8
  pool: 5
  username: root
  password:
  socket: /tmp/mysql.sock
  
development:
  <<: *default
  database: file_sync_osx_development
  
test:
  <<: *default
  database: file_sync_osx_test
```

## How to run?

1. Create database:
  `rake db:create`
  `rake db:migrate`
2. Get run application:
`rails s` and go to browser with url:  http://localhost:3000/swagger  