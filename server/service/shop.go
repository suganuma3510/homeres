package service

import (
	"context"
	"net/url"

	"github.com/suganuma3510/homeres/domain/model"
	"github.com/suganuma3510/homeres/domain/repository"

)

// ShopService : ShopにおけるServiceのインターフェース
type ShopService interface {
	GetShopList(context.Context, url.Values) (*model.Shop, error)
}

type shopService struct {
	shopRepository repository.ShopRepository
}

// NewShopService : Shopデータに関するServiceを生成
func NewShopService(sr repository.ShopRepository) ShopService {
	return &shopService{
		shopRepository: sr,
	}
}

// GetShopList : Shopデータのリストを取得する
func (ss shopService) GetShopList(ctx context.Context, param url.Values) (shops *model.Shop, err error) {
	// Persistence（Repository）を呼出
	shops, err = ss.shopRepository.GetShopList(ctx, param)
	if err != nil {
		return nil, err
	}
	return shops, nil
}
