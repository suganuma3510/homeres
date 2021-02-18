package repository

import (
	"context"
	"net/url"

	"github.com/suganuma3510/homeres/domain/model"
)

type ShopRepository interface {
	GetShopList(context.Context, url.Values) (*model.Shop, error)
}
