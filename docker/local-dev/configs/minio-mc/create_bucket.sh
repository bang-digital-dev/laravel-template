#!/bin/sh

/usr/bin/mc config host add s3 "http://${MINIO_HOST}:9000" "${MINIO_USER}" "${MINIO_PASSWORD}" --api S3v4;

[[ ! -z "`/usr/bin/mc ls s3 | grep challenge`" ]] || /usr/bin/mc mb s3/${MINIO_BUCKET};

/usr/bin/mc policy download s3/${MINIO_BUCKET};

exit 0;
