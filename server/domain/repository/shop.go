package repository

import (
	"context"
	"github.com/suganuma3510/homeres/domain/model"
)

type ShopRepository interface {
	GetShopList(context.Context) (*model.Shop, error)
}
