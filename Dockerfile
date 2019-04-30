FROM golang:1.12-alpine3.9 as builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . ./

RUN CGO_ENABLED=0 go build -o app


###
FROM alpine:3.9

WORKDIR /app

COPY --from=builder /app/app ./

USER nobody
CMD [ "./app" ]