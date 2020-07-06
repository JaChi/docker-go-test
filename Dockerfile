FROM golang:alpine AS builder
WORKDIR /code
ADD demo-go-webapp/*.go /code/
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o /code/main .

FROM alpine:3.6
WORKDIR /app/
COPY demo-go-webapp/templates /app/templates
COPY demo-go-webapp/static /app/static
COPY --from=builder /code/main /app/
EXPOSE 3535
CMD ["/app/main"] 

