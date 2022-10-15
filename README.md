# Image Compressor

Uses:
Ruby 3.1.2 (latest)
Rails 7.0.4 (latest)
ActiveStorage (as default Rails files management gem, could be something else)
Minio (as simple S3 alternative)
PostgreSQL (for records persistence, can be done without persistence and db altogether though)
Redis & Sidekiq (for jobs as required)
TailwindCSS (as experiment :)

(docker-compose.yml can be and should be optimized - my bad)

## Running in production mode (everything is dockerized)
```
docker-compose up
```

Web interface:
[http://localhost:3000](http://localhost:3000)

MailCatcher:
[http://localhost:1080](http://localhost:1080)

API mode (using curl for example):
```
curl \
  -v \
  -H "Accept: application/json" \
  -F "email=one@example.com" \
  -F "image_file=@test/fixtures/files/good.jpg" \
  http://localhost:3000/images/compress
```

## Running in development mode (only external services are dockerized)

Requirements:
Ruby 3.1.2
Vips for image processing (`brew install vips`)

Run dockerized services and keep them running:
```
docker-compose -f docker-compose-dev.yml up
```

Install bundled gems and setup the database in another terminal:
```
bundle
rails db:setup
```

Run the app:
```
bin/dev
```

## Running tests
Run dockerized services in one terminal (same as in development):
```
docker-compose -f docker-compose-dev.yml up
```

Create test database:
```
RAILS_ENV=test rails db:create
```

Run the tests:
```
rails test
```

