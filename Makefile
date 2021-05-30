IMAGE_NAME=srzzumix/unityhub

help: ## Display this help screen
	@grep -E '^[a-zA-Z][a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sed -e 's/^GNUmakefile://' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

build: ## build docker image
	docker build -t ${IMAGE_NAME} .

run: ## run bash in docker
	docker run -it --rm --entrypoint bash ${IMAGE_NAME}

hub: ## run unityhub (e.g. make hub OPT=help)
	docker run -it --rm ${IMAGE_NAME} ${OPT}

version: ## show hub version
	docker run --rm --entrypoint cat ${IMAGE_NAME} /opt/unity/UnityHub/unityhub.desktop | grep Version | sed s/.*=//

rmi:
	docker image rm ${IMAGE_NAME}
