# Benchmark

- Container conditions:
    - 1 CPU
    - 512m memory

```
docker run --cpus=1 --memory=512m -p 8080:80 laravel-7.25.0:latest
```

- Test conditions: 
    - Concurrent 15
    - Duration 60 seconds (1 minute)

```
# Using wrk
wrk -t 1 -c 15 -d 60 http://localhost:8080/

# Using ab
ab -t 60 -c 15 http://localhost:8080/
```

# Results

Unit: Requests/sec

## Laravel 7.25.0

- Alpine 3.12
    - PHP 7.4.10: 105.34
- Buster
    - PHP 7.4.10: 108.23