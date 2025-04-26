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

submit:
	docker exec lc-spark-master spark-submit --master spark://spark-master:7077 --deploy-mode client ./apps/$(app)



