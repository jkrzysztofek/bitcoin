# README

# Bitcoin

App for comparing bitcoin exchange rates in last years

## Getting Started

Things you may want to cover:

* Ruby version 2.5.1

* Rails version 5.2.1

### Installing

Download zip package and install required gems by running:

```
bundle install
```

Database initialization, run:

```
rails db:create
```

```
rails db:migrate
```

Download bitcoin exchange rates from Cryptocompare Api by typing in rails console:

```
ExchangeRate.import
```

Finnaly run rails server:

```
rails server
```

You can find app now by pointing your browser to http://localhost:3000.
