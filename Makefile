VERSION_FILE=.version
NOW_VERSION:=$(shell cat ${VERSION_FILE})
INCREMENT_PARAM=bug
VERSION_SH_URL=https://gist.githubusercontent.com/a4t/c75d5b7adb049e506784f9b8dd16de4d/raw/c13a3b77614a8ff9c7a5c6c1ff672ed92393ef88/version.sh

version+:;   $(MAKE) version-increment INCREMENT_PARAM=bug
version++:;  $(MAKE) version-increment INCREMENT_PARAM=feature
version+++:; $(MAKE) version-increment INCREMENT_PARAM=major
version-increment:
	curl -sSL ${VERSION_SH_URL} | sh -s ${NOW_VERSION} ${INCREMENT_PARAM} > ${VERSION_FILE}

release-tag:
	git tag ${NOW_VERSION}
	git push origin ${NOW_VERSION}
