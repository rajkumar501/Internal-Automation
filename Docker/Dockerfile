FROM golang:1.23
WORKDIR /src
COPY <<EOF ./main.go 
package main

import "fmt"

func main () {
    fmt.Println("Hello Docker")
}

EOF


RUN go build -o /bin/hello ./main.go

FROM scratch
COPY"" --from=0 /bin/hello /bin/hello
CMD["/bin/hello"]