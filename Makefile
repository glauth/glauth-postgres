# Note: to make a plugin compatible with a binary built in debug mode, add `-gcflags='all=-N -l'`

PLUGIN_OS ?= linux
PLUGIN_ARCH ?= amd64

plugin_postgres: bin/$(PLUGIN_OS)$(PLUGIN_ARCH)/postgres.so

bin/$(PLUGIN_OS)$(PLUGIN_ARCH)/postgres.so: pkg/plugins/glauth-postgres/postgres.go
	GOOS=$(PLUGIN_OS) GOARCH=$(PLUGIN_ARCH) go build ${TRIM_FLAGS} -ldflags "${BUILD_VARS}" -buildmode=plugin -o $@ $^

plugin_postgres_linux_amd64:
	PLUGIN_OS=linux PLUGIN_ARCH=amd64 make plugin_postgres

plugin_postgres_linux_arm64:
	PLUGIN_OS=linux PLUGIN_ARCH=arm64 make plugin_postgres

plugin_postgres_darwin_amd64:
	PLUGIN_OS=darwin PLUGIN_ARCH=amd64 make plugin_postgres

plugin_postgres_darwin_arm64:
	PLUGIN_OS=darwin PLUGIN_ARCH=arm64 make plugin_postgres
