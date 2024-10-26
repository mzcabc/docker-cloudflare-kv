FROM alpine

RUN set -ex \
	&& apk add --no-cache \
	curl \
	jq

# copy the script to the image
WORKDIR /app

COPY ./script.sh .

VOLUME [ "/kv" ]

ENTRYPOINT ["sh", "script.sh"]
