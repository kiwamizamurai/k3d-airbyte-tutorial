.DEFAULT_GOAL := help

.PHONY: help
help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

CLUSTER_NAME=myk3dcluster

.PHONY: create
create: ## Create cluster
	k3d cluster create $(CLUSTER_NAME) -p "8081:80@loadbalancer" --agents 2

.PHONY: up
up: ## Start Cluster
	k3d cluster start $(CLUSTER_NAME)

.PHONY: down
down: ## Stop Cluster
	k3d cluster stop $(CLUSTER_NAME)

.PHONY: destroy
destroy: ## Clean Cluster
	k3d cluster delete $(CLUSTER_NAME)

.PHONY: getall
getall: ## Get all
	kubectl get all -n airbyte

.PHONY: getpods
getpods: ## Get pods
	kubectl get pods -n airbyte

.PHONY: monitor
monitor: ## Monitor
	k9s --readonly -n airbyte
