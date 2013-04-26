sellstuff.rb
============

sell your stuff with a ruby online listing tool


requirements
============

this app has been developed and tested under ruby-1.9.3-p327

installing
==========

install bundler:

```
gem install bundler
```

install the required libraries:

```
bundle install
```

create the initial database:

```
RACK_ENV=production bundle exec padrino rake db:migrate
```

populate the database with item categories and an admin account:

```
RACK_ENV=production bundle exec padrino rake db:seed
```

running
=======

```
RACK_ENV=production rackup -D
```

the server will run on port 9292 by default, you can override it using the -p PORT flag

