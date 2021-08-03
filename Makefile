-include .makefiles/Makefile
-include .makefiles/pkg/go/v1/Makefile
-include .makefiles/ext/na4ma4/lib/golangci-lint/v1/Makefile

.makefiles/ext/na4ma4/%: .makefiles/Makefile
	@curl -sfL https://raw.githubusercontent.com/na4ma4/makefiles-ext/main/v1/install | bash /dev/stdin "$@"

.makefiles/%:
	@curl -sfL https://makefiles.dev/v1 | bash /dev/stdin "$@"

######################
# Linting
######################

ERRCHECK := artifacts/bin/errcheck
$(ERRCHECK):
	-@mkdir -p "$(MF_PROJECT_ROOT)/$(@D)"
	GOBIN="$(MF_PROJECT_ROOT)/$(@D)" go get github.com/kisielk/errcheck

artifacts/errcheck/lint: errcheck-exclude.txt $(ERRCHECK) $(GENERATED_FILES) $(GO_TEST_REQ) $(GO_SOURCE_FILES)
	-@mkdir -p "$(@D)"
	cat "$(<)"
	-$(ERRCHECK) -verbose ./...
	$(ERRCHECK) -verbose -exclude $(<) ./... | tee "$(@)"

lint:: artifacts/errcheck/lint

ci:: lint
