# golangci-lint-errcheck-test

errcheck linter test

## errcheck

```shell
$ make artifacts/errcheck/lint

cat "errcheck-exclude.txt"
(io.Closer).Close

artifacts/bin/errcheck -verbose ./...
checking github.com/na4ma4/golangci-lint-errcheck-test/cmd/errcheck-test
cmd/errcheck-test/main.go:23:23:	(io.Closer).Close	defer resp.Body.Close()
make: [artifacts/errcheck/lint] Error 1 (ignored)

artifacts/bin/errcheck -verbose -exclude errcheck-exclude.txt ./... | tee "artifacts/errcheck/lint"
checking github.com/na4ma4/golangci-lint-errcheck-test/cmd/errcheck-test
```

## golangci-lint

```shell
$ artifacts/bin/v1.41.1/golangci-lint run --sort-results --max-same-issues 0 --max-issues-per-linter 0  ./... | tee "artifacts/lint/golangci-lint"

cmd/errcheck-test/main.go:23:23: Error return value of `resp.Body.Close` is not checked (errcheck)
    defer resp.Body.Close()
                         ^
make: *** [artifacts/lint/golangci-lint] Error 1
make: *** Deleting file `artifacts/lint/golangci-lint'
```

.golangci.yml:

```yaml
linters:
  enable:
    - errcheck

issues:
  exclude-use-default: false

linters-settings:
  errcheck:
    exclude-functions:
    - (io.Closer).Close
```
