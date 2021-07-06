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

# Comparison

## with bitnami/laravel

- Based on Laravel 8.5.20 (locked version number for comparison).
- Environment:

```
# Assign versions
export VERSION_LARAVEL=8.5.20

```

- Test with bitnami/laravel: `make downbitnami; make cleanbitnami; make buildlaravelbitnami; make testbitnami`
    - (Having some tests here.)

```
❯ wrk -t 1 -c 1 -d 60 http://localhost:8082/
Running 1m test @ http://localhost:8082/
  1 threads and 1 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   128.29ms   14.41ms 228.88ms   89.91%
    Req/Sec     8.20      2.44    10.00     72.96%
  466 requests in 1.00m, 8.27MB read
  Socket errors: connect 0, read 466, write 0, timeout 0
Requests/sec:      7.77
Transfer/sec:    141.04KB
```

```
❯ wrk -t 1 -c 1 -d 60 http://localhost:8082/
Running 1m test @ http://localhost:8082/
  1 threads and 1 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   133.35ms   16.68ms 250.74ms   85.75%
    Req/Sec     7.90      2.57    10.00     68.15%
  449 requests in 1.00m, 7.96MB read
  Socket errors: connect 0, read 449, write 0, timeout 0
Requests/sec:      7.47
Transfer/sec:    135.71KB
```

```
❯ wrk -t 1 -c 1 -d 60 http://localhost:8082/
Running 1m test @ http://localhost:8082/
  1 threads and 1 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   130.19ms   14.16ms 210.50ms   85.84%
    Req/Sec     8.10      2.53    10.00     71.24%
  459 requests in 1.00m, 8.14MB read
  Socket errors: connect 0, read 459, write 0, timeout 0
Requests/sec:      7.65
Transfer/sec:    138.92KB
```

- Differences between `bitnami/laravel` and `dwchiang/nginx-php-fpm` Laravel example:
    - OS_ARCH: `linux/amd64` only **v.s** support `linux/arm64` and `linux/amd64` both
    - OS: `bitnami/minideb` **v.s** `buster`
    - Packages flexibility. (Depends on how you are going to deal with your Dockerfile.)
    - HTTP server: `PHP's built-in development server` **v.s** `nginx`
    - PHP version
    - Laravel version
- Environment for this project:

```
# Assign versions
export VERSION_OS=buster

export VERSION_PHP_FPM=7.4.21
export VERSION_NGINX=1.20.1
export VERSION_LARAVEL=8.5.20
```

- Test results of this project base:

```
❯ wrk -t 1 -c 1 -d 60 http://localhost:8082/
Running 1m test @ http://localhost:8082/
  1 threads and 1 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    21.39ms   76.06ms   1.02s    97.69%
    Req/Sec    96.66     24.54   141.00     71.82%
  5645 requests in 1.00m, 100.35MB read
Requests/sec:     94.08
Transfer/sec:      1.67MB
```

```
❯ wrk -t 1 -c 1 -d 60 http://localhost:8082/
Running 1m test @ http://localhost:8082/
  1 threads and 1 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    11.12ms   10.17ms 176.86ms   94.32%
    Req/Sec   103.94     24.86   140.00     69.35%
  6206 requests in 1.00m, 110.33MB read
Requests/sec:    103.37
Transfer/sec:      1.84MB
```

```
❯ wrk -t 1 -c 1 -d 60 http://localhost:8082/
Running 1m test @ http://localhost:8082/
  1 threads and 1 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency    11.38ms   10.03ms 189.06ms   94.14%
    Req/Sec   100.12     23.62   141.00     73.03%
  5979 requests in 1.00m, 106.29MB read
Requests/sec:     99.58
Transfer/sec:      1.77MB
```