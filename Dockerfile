
FROM	python:3.12
ADD	./src	/src
COPY	./requirements.txt	/src/requirements.txt
RUN	pip install -r /src/requirements.txt
RUN	adduser --system --no-create-home controller
USER	controller
CMD	["kopf","run","/src/userinit.py","--verbose"]
LABEL	org.opencontainers.image.version=${GIT_HASH}
LABEL	org.opencontainers.image.created=${BUILD_DATE}
LABEL	org.opencontainers.image.documentation="https://github.com/Ramblurr/crunchy-userinit-controller"
LABEL	org.opencontainers.image.source="https://github.com/Ramblurr/crunchy-userinit-controller"
LABEL	org.opencontainers.image.vendor="@ramblurr"
