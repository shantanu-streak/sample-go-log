# syntax=docker/dockerfile:1

FROM golang:1.18

WORKDIR /app

COPY . .

RUN go mod download
RUN go mod tidy

RUN go build -o main -ldflags=-X=main.version=${VERSION} main.go 

FROM alpine:latest


COPY --from=0  /app ./

EXPOSE 8080

CMD [ "./main" ]