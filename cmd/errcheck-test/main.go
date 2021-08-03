package main

import (
	"context"
	"log"
	"net/http"
)

func checkErr(err error) {
	if err != nil {
		panic(err)
	}
}

func main() {
	ctx := context.Background()

	r, err := http.NewRequestWithContext(ctx, http.MethodGet, "https://www.google.com.au", nil)
	checkErr(err)

	resp, err := http.DefaultClient.Do(r)
	checkErr(err)
	defer resp.Body.Close()

	log.Printf("HTTP Status Code: %d", resp.StatusCode)
}
