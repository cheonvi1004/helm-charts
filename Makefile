.PHONY: default
default: build

.PHONY: build
build:
	for d in $$(\ls -1F | grep '/$$' | grep -v docs/); do \
        helm package $$d -d docs/; \
    done; \
    helm repo index docs/ --url https://sacloud.github.io/helm-charts


