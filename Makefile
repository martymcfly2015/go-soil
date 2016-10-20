# This Makefile is meant to be used by people that do not usually work
# with Go source code. If you know what GOPATH is then you probably
# don't need to bother with make.

.PHONY: gsoil gsoil-cross evm all test travis-test-with-coverage xgo clean
.PHONY: gsoil-linux gsoil-linux-arm gsoil-linux-386 gsoil-linux-amd64
.PHONY: gsoil-darwin gsoil-darwin-386 gsoil-darwin-amd64
.PHONY: gsoil-windows gsoil-windows-386 gsoil-windows-amd64
.PHONY: gsoil-android gsoil-android-16 gsoil-android-21

GOBIN = build/bin

MODE ?= default
GO ?= latest

gsoil:
	build/env.sh go install -v $(shell build/flags.sh) ./cmd/gsoil
	@echo "Done building."
	@echo "Run \"$(GOBIN)/gsoil\" to launch gsoil."

gsoil-cross: gsoil-linux gsoil-darwin gsoil-windows gsoil-android
	@echo "Full cross compilation done:"
	@ls -l $(GOBIN)/gsoil-*

gsoil-linux: xgo gsoil-linux-arm gsoil-linux-386 gsoil-linux-amd64
	@echo "Linux cross compilation done:"
	@ls -l $(GOBIN)/gsoil-linux-*

gsoil-linux-386: xgo
	build/env.sh $(GOBIN)/xgo --go=$(GO) --buildmode=$(MODE) --dest=$(GOBIN) --targets=linux/386 -v $(shell build/flags.sh) ./cmd/gsoil
	@echo "Linux 386 cross compilation done:"
	@ls -l $(GOBIN)/gsoil-linux-* | grep 386

gsoil-linux-amd64: xgo
	build/env.sh $(GOBIN)/xgo --go=$(GO) --buildmode=$(MODE) --dest=$(GOBIN) --targets=linux/amd64 -v $(shell build/flags.sh) ./cmd/gsoil
	@echo "Linux amd64 cross compilation done:"
	@ls -l $(GOBIN)/gsoil-linux-* | grep amd64

gsoil-linux-arm: gsoil-linux-arm-5 gsoil-linux-arm-6 gsoil-linux-arm-7 gsoil-linux-arm64
	@echo "Linux ARM cross compilation done:"
	@ls -l $(GOBIN)/gsoil-linux-* | grep arm

gsoil-linux-arm-5: xgo
	build/env.sh $(GOBIN)/xgo --go=$(GO) --buildmode=$(MODE) --dest=$(GOBIN) --targets=linux/arm-5 -v $(shell build/flags.sh) ./cmd/gsoil
	@echo "Linux ARMv5 cross compilation done:"
	@ls -l $(GOBIN)/gsoil-linux-* | grep arm-5

gsoil-linux-arm-6: xgo
	build/env.sh $(GOBIN)/xgo --go=$(GO) --buildmode=$(MODE) --dest=$(GOBIN) --targets=linux/arm-6 -v $(shell build/flags.sh) ./cmd/gsoil
	@echo "Linux ARMv6 cross compilation done:"
	@ls -l $(GOBIN)/gsoil-linux-* | grep arm-6

gsoil-linux-arm-7: xgo
	build/env.sh $(GOBIN)/xgo --go=$(GO) --buildmode=$(MODE) --dest=$(GOBIN) --targets=linux/arm-7 -v $(shell build/flags.sh) ./cmd/gsoil
	@echo "Linux ARMv7 cross compilation done:"
	@ls -l $(GOBIN)/gsoil-linux-* | grep arm-7

gsoil-linux-arm64: xgo
	build/env.sh $(GOBIN)/xgo --go=$(GO) --buildmode=$(MODE) --dest=$(GOBIN) --targets=linux/arm64 -v $(shell build/flags.sh) ./cmd/gsoil
	@echo "Linux ARM64 cross compilation done:"
	@ls -l $(GOBIN)/gsoil-linux-* | grep arm64

gsoil-darwin: gsoil-darwin-386 gsoil-darwin-amd64
	@echo "Darwin cross compilation done:"
	@ls -l $(GOBIN)/gsoil-darwin-*

gsoil-darwin-386: xgo
	build/env.sh $(GOBIN)/xgo --go=$(GO) --buildmode=$(MODE) --dest=$(GOBIN) --targets=darwin/386 -v $(shell build/flags.sh) ./cmd/gsoil
	@echo "Darwin 386 cross compilation done:"
	@ls -l $(GOBIN)/gsoil-darwin-* | grep 386

gsoil-darwin-amd64: xgo
	build/env.sh $(GOBIN)/xgo --go=$(GO) --buildmode=$(MODE) --dest=$(GOBIN) --targets=darwin/amd64 -v $(shell build/flags.sh) ./cmd/gsoil
	@echo "Darwin amd64 cross compilation done:"
	@ls -l $(GOBIN)/gsoil-darwin-* | grep amd64

gsoil-windows: xgo gsoil-windows-386 gsoil-windows-amd64
	@echo "Windows cross compilation done:"
	@ls -l $(GOBIN)/gsoil-windows-*

gsoil-windows-386: xgo
	build/env.sh $(GOBIN)/xgo --go=$(GO) --buildmode=$(MODE) --dest=$(GOBIN) --targets=windows/386 -v $(shell build/flags.sh) ./cmd/gsoil
	@echo "Windows 386 cross compilation done:"
	@ls -l $(GOBIN)/gsoil-windows-* | grep 386

gsoil-windows-amd64: xgo
	build/env.sh $(GOBIN)/xgo --go=$(GO) --buildmode=$(MODE) --dest=$(GOBIN) --targets=windows/amd64 -v $(shell build/flags.sh) ./cmd/gsoil
	@echo "Windows amd64 cross compilation done:"
	@ls -l $(GOBIN)/gsoil-windows-* | grep amd64

gsoil-android: xgo
	build/env.sh $(GOBIN)/xgo --go=$(GO) --buildmode=$(MODE) --dest=$(GOBIN) --targets=android/* -v $(shell build/flags.sh) ./cmd/gsoil
	@echo "Android cross compilation done:"
	@ls -l $(GOBIN)/gsoil-android-*

gsoil-ios: gsoil-ios-arm-7 gsoil-ios-arm64
	@echo "iOS cross compilation done:"
	@ls -l $(GOBIN)/gsoil-ios-*

gsoil-ios-arm-7: xgo
	build/env.sh $(GOBIN)/xgo --go=$(GO) --buildmode=$(MODE) --dest=$(GOBIN) --targets=ios/arm-7 -v $(shell build/flags.sh) ./cmd/gsoil
	@echo "iOS ARMv7 cross compilation done:"
	@ls -l $(GOBIN)/gsoil-ios-* | grep arm-7

gsoil-ios-arm64: xgo
	build/env.sh $(GOBIN)/xgo --go=$(GO) --buildmode=$(MODE) --dest=$(GOBIN) --targets=ios-7.0/arm64 -v $(shell build/flags.sh) ./cmd/gsoil
	@echo "iOS ARM64 cross compilation done:"
	@ls -l $(GOBIN)/gsoil-ios-* | grep arm64

evm:
	build/env.sh $(GOROOT)/bin/go install -v $(shell build/flags.sh) ./cmd/evm
	@echo "Done building."
	@echo "Run \"$(GOBIN)/evm to start the evm."

all:
	build/env.sh go install -v $(shell build/flags.sh) ./...

test: all
	build/env.sh go test ./...

travis-test-with-coverage: all
	build/env.sh build/test-global-coverage.sh

xgo:
	build/env.sh go get github.com/karalabe/xgo

clean:
	rm -fr build/_workspace/pkg/ Godeps/_workspace/pkg $(GOBIN)/*
