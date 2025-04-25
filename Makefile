build:
	docker compose build

images:
	docker compose images

down:
	docker compose down --volumes --remove-orphans

stop:
	docker compose stop

remove:
	docker compose rm

run:
	docker compose up --scale spark-worker=$(worker_count)



