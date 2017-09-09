# Configuration parameters
#cull in 3600 secs= 60 min
CULL_PERIOD ?= 600
CULL_TIMEOUT ?= 600
CULL_MAX ?= 14400
LOGGING ?= debug
POOL_SIZE ?= 4
DOCKER_HOST ?= 127.0.0.1
DOCKER_NETWORK_NAME ?= tmpnb


#the tmpnb is built, not pulled.
tmpnb-image: Dockerfile
	docker build -t jupyter/tmpnb .

images: tmpnb-image demo-image minimal-image

minimal-image:
	docker pull jupyter/minimal-notebook

demo-image:
	docker pull jupyter/demo

proxy-image:
	docker pull jupyter/configurable-http-proxy

network:
	@docker network inspect $(DOCKER_NETWORK_NAME) >/dev/null 2>&1 || docker network create $(DOCKER_NETWORK_NAME)

proxy: proxy-image network
	docker run -d -e CONFIGPROXY_AUTH_TOKEN=devtoken \
		--network $(DOCKER_NETWORK_NAME) \
		-p 80:8000 \
		-p 8001:8001 \
		--name proxy \
		jupyter/configurable-http-proxy \
		--default-target http://tmpnb:9999 --api-ip 0.0.0.0 --log-level debug

tmpnb: tmpnb-image network
	docker run -d -e CONFIGPROXY_AUTH_TOKEN=devtoken \
		-e CONFIGPROXY_ENDPOINT=http://proxy:8001 \
		--network $(DOCKER_NETWORK_NAME) \
		--name tmpnb \
		-v /var/run/docker.sock:/docker.sock jupyter/tmpnb python orchestrate.py \
		--image="wodeai/tensorflow" --cull_timeout=$(CULL_TIMEOUT) --cull_period=$(CULL_PERIOD) \
		--logging=$(LOGGING) --pool_size=$(POOL_SIZE) --cull_max=$(CULL_MAX) \
		--docker_network=$(DOCKER_NETWORK_NAME) \
		--host-directories=/data:/home/jovyan/data \
	        --use_tokens=0 --mem-limit=2048000000 
#		--command="ln -s /mnt/vol0 ~/data && jupyter notebook $@ "
dev: cleanup network proxy tmpnb check #open

open:
	docker ps | grep tmpnb
	-open http:`echo $(DOCKER_HOST) | cut -d":" -f2`:80

check:
	docker ps -a

cleanup:
	-docker stop `docker ps -a -q` #`docker ps -aq --filter name=tmpnb --filter name=proxy --filter name=minimal-notebook`
	-docker rm   `docker ps -a -q` #`docker ps -aq --filter name=tmpnb --filter name=proxy --filter name=minimal-notebook`
	-docker images -q --filter "dangling=true" | xargs docker rmi

log-tmpnb:
	docker logs -f tmpnb

log-proxy:
	docker logs -f proxy


.PHONY: cleanup
