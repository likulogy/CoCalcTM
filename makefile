build:
	docker build -t cocalc_tm .
start:
	sudo docker start cucalc
stop:
	sudo docker stop cucalc
rm:
	sudo docker rm cucalc
