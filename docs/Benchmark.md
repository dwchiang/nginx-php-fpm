# Benchmark

- Test environment:
    - MacBook Pro (13-inch, 2020, Four Thunderbolt 3 ports)
    - CPU 2 GHz Quad-Core Intel Core i5
    - Docker-compose Container conditions:
        - 1 CPU
        - 512m memory
- Test preparation:
    - Clean containers. `make down; make test;`
- Test conditions: 
    - Concurrent 15
    - Duration 60 seconds (1 minute)

```
# Using wrk
wrk -t 1 -c 15 -d 60 http://localhost:8082/
wrk -t 1 -c 15 -d 60 http://localhost:8082/names
```

```
# Using ab
ab -t 60 -c 15 http://localhost:8082/
```

# Benchmark Results

Unit: **Requests/sec**

## Laravel 7.25.0 Homepage (View only)

- Alpine 3.12
    - PHP 7.4.10: **112.09**
    - PHP 7.3.22: **112.00**
- Buster
    - PHP 7.4.10: **120.75**
    - PHP 7.3.22: **118.18**

## Laravel 7.25.0 Names (with a database query for 50 user records)

- Alpine 3.12
    - PHP 7.4.10: **69.44**
    - PHP 7.3.22: **70.74**
- Buster
    - PHP 7.4.10: **74.66**
    - PHP 7.3.22: **74.05**
