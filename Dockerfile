FROM docker.io/golang:1.23.0 as stage1

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o main .

# stage2 - use distroless image
FROM gcr.io/distroless/base

COPY --from=stage1 /app/main .

COPY --from=stage1 /app/static ./static

EXPOSE 8080

CMD ["./main"]




