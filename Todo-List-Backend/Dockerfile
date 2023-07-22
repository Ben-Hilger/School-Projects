FROM golang:alpine
 
RUN apk update && \
apk upgrade

WORKDIR /

COPY build/docker-build docker-build

ENV PORT=8080
ENV PRIVATEKEY="9a32909f23d6313c62633b1215bab9243c07a1aac83175fbefe116dc889bb1a3"

EXPOSE 8080

CMD ["./docker-build"]
