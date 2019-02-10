BUILD_VERSION   := $(shell cat version)
BUILD_DATE      := $(shell date "+%F %T")
COMMIT_SHA1     := $(shell git rev-parse HEAD)

all:
	gox -osarch="darwin/amd64 linux/386 linux/amd64" \
        -output="dist/{{.Dir}}_{{.OS}}_{{.Arch}}" \
    	-ldflags   "-X 'github.com/mritd/gitflow-toolkit/cmd.Version=${BUILD_VERSION}' \
                    -X 'github.com/mritd/gitflow-toolkit/cmd.BuildTime=${BUILD_TIME}' \
                    -X 'github.com/mritd/gitflow-toolkit/cmd.CommitID=${COMMIT_SHA1}' \
                    -w -s"

release: all
	ghr -u mritd -t ${GITHUB_RELEASE_TOKEN} -replace -recreate --debug ${BUILD_VERSION} dist

clean:
	rm -rf dist

install:
	go install -ldflags "-X 'github.com/mritd/gitflow-toolkit/cmd.Version=${BUILD_VERSION}' \
                         -X 'github.com/mritd/gitflow-toolkit/cmd.BuildTime=${BUILD_TIME}' \
                         -X 'github.com/mritd/gitflow-toolkit/cmd.CommitID=${COMMIT_SHA1}' \
                         -w -s"

.PHONY : all release clean install

.EXPORT_ALL_VARIABLES:

GO111MODULE = on