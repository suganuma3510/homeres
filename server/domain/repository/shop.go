package repository

import (
	"context"
	"github.com/suganuma3510/homeres/domain/model"
	"net/url"
)

type ShopRepository interface {
	GetShopList(context.Context, url.Values) (*model.Shop, error)
}
