package controller

import (
	"github.com/labstack/echo"
	"github.com/suganuma3510/homeres/service"
	"net/http"
)

// ShopController : ShopにおけるControllerのインターフェース
type ShopController interface {
	GetShopList(e echo.Context) error
}

type shopController struct {
	shopService service.ShopService
}

// NewShopService : Shopデータに関するControllerを生成
func NewShopController(ss service.ShopService) ShopController {
	return &shopController{
		shopService: ss,
	}
}

// GetShopList : Shopデータのリストを取得し返却
func (sc shopController) GetShopList(c echo.Context) error {

	ctx := c.Request().Context()
	param := c.QueryParams()

	shops, err := sc.shopService.GetShopList(ctx, param)

	if err != nil {
		return c.String(http.StatusBadRequest, "Validate is failed: "+err.Error())
	}
	return c.JSON(http.StatusOK, shops)
}
