package main

import (
    "net/http"

    "github.com/labstack/echo"
    _ "github.com/go-sql-driver/mysql"
)

func main() {
    e := echo.New()
    e.GET("/", func(c echo.Context) error {
        return c.String(http.StatusOK, "Hello world")
    })
    e.Logger.Fatal(e.Start(":3000"))
}
