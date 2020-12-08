package main

import (
	"github.com/labstack/echo"
	"github.com/suganuma3510/homeres/infra/datastore"
	"github.com/suganuma3510/homeres/interface/controller"
	"github.com/suganuma3510/homeres/service"
)

func main() {
	e := echo.New()

	shopPersistence := datastore.NewShopRepository()
	shopService := service.NewShopService(shopPersistence)
	shopController := controller.NewShopController(shopService)

	e.GET("shops/search", shopController.GetShopList)

	e.Logger.Fatal(e.Start(":3000"))
}
