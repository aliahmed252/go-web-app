FROM golang:1.22.5 AS base  
# the base just to build the binary file (main)

WORKDIR /app

COPY go.mod . 
# this is the dependencies file in golang

RUN go mod download 
# the command to install the dependencies file

COPY . . 
#copy the rest files

RUN go build -o main . 
# to build the image

#final image 
FROM gcr.io/distroless/base
# Use Distroless as a minimal runtime image for better security and smaller footprint.
# It contains only the application and its runtime dependencies, no shell or package manager.

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080 
# just for annoucment that the used port in container is 8080 not execute anything

CMD [ "./main" ] 
# to run the binary file