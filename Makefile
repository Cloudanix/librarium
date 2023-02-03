.PHONY: initialize start commit build

IMAGE:=spectrocloud/librarium
# Retrieve all modified files in the content folder and compare the difference between the master branch git tree blob AND this commit's git tree blob
CHANGED_FILE=$(shell git diff-tree -r --no-commit-id --name-only master HEAD | grep content)

clean:
	rm -rf node_modules build public .cache
	docker image rm $(IMAGE)

initialize:
	npm ci

start:
	npm run start

commit:
	git add .
	git commit -am "$(MESSAGE)"
	git push origin HEAD
	./scripts/open-pr.sh

build:
	rm -rf public
	npm run build

docker-image:
	docker build -t $(IMAGE) .

docker-start:
	docker run --rm -it -v $(CURDIR)/content:/librarium/content/ -p 9000:9000 $(IMAGE)

verify-url-links:
	rm link_report.csv || echo "No report exists. Proceeding to scan step"
	npx linkinator https://docs.spectrocloud.com/ --recurse --timeout 60000 --format csv >> link_report.csv

verify-url-links-local: build
	rm link_report.csv || echo "No report exists. Proceeding to scan step"
	npm run test-links

sync-vale:
	vale sync

check-writing: 
	vale $(CHANGED_FILE) 

fix-server:
	@echo "fixing server"
	rm -rfv node_modules && rm -rfv .cache/ && npm ci