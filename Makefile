PROJECT:=go-zero-looklook

.PHONY: build
build:
	CGO_ENABLED=0 go build -ldflags="-w -s" -a -installsuffix "" -o go-zero-looklook .

# make build-linux
build-linux:
	@docker build -t go-zero-looklook:latest .
	@echo "build successful"

build-sqlite:
	go build -tags sqlite3 -ldflags="-w -s" -a -installsuffix -o go-zero-looklook .

# make run
run-env:
    # 启动方法一 run go-zero-looklook-api container  docker-compose 启动方式
    # 进入到项目根目录 执行 make run 命令
	@docker-compose -f docker-compose-env.yml  up -d

	@echo "go-zero-looklook env service is running..."

	# delete Tag=<none> 的镜像
	@docker image prune -f

stop-env:
	@docker-compose -f docker-compose-env.yml  down
	@echo "go-zero-looklook env service is down..."


#.PHONY: test
#test:
#	go test -v ./... -cover

#.PHONY: docker
#docker:
#	docker build . -t go-zero-looklook:latest

# make deploy
deploy:

	#@git checkout master
	#@git pull origin master
	make build-linux

