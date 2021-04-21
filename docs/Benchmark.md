# Benchmark

- Test environment:
    - MacBook Pro (13-inch, 2020, Four Thunderbolt 3 ports)
    - CPU 2 GHz Quad-Core Intel Core i5 (x86)
    - Docker-compose Container conditions:
        - 1 CPU
        - 512m memory
- Test preparation:
    - Make sure to have a clean testing environment **every time**: `make down; make clean; make buildlaravel; make test`
    - Wait couple seconds, then: `make seedlaravel`
        - which will do the database migrate and seeding (50 fake users) by executing `php artisan migrate; php artisan db:seed` in the container.
    - Check the URL in a browser to make sure it works before hitting by any testing tool.
- Test conditions: 
    - Concurrent 1
    - Duration 60 seconds (1 minute)

```
# Using wrk
wrk -t 1 -c 1 -d 60 http://localhost:8082/
wrk -t 1 -c 1 -d 60 http://localhost:8082/names
```

```
# Using ab
ab -t 60 -c 1 http://localhost:8082/
```

# Benchmark Results

Please refer to Ernest's blog post:

- (zh) [Laravel PHP8/PHP7 Debian/Alpine 容器效能比較](https://www.ernestchiang.com/zh/posts/2021/2021-04-17-benchmark-nginx-php-fpm-between-buster-alpine/)
- (en) on-going
