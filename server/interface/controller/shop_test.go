package controller

import (
	"context"
	"encoding/json"
	"github.com/golang/mock/gomock"
	"github.com/labstack/echo"
	"github.com/suganuma3510/homeres/domain/model"
	"github.com/suganuma3510/homeres/service"
	"github.com/suganuma3510/homeres/service/mock"
	"net/http"
	"net/http/httptest"
	"net/url"
	"reflect"
	"testing"
)

func TestGetShopList(t *testing.T) {
	ctrl := gomock.NewController(t)
	defer ctrl.Finish()
	/* mock := mock_service.NewMockShopService(ctrl) */

	type fields struct {
		shopService service.ShopService
	}

	type want struct {
		body *model.Shop
		err  error
	}

	type mockReturns struct {
		shop *model.Shop
		err  error
	}

	tests := []struct {
		name   string
		fields fields
		want
		mockReturns
	}{
		{
			name: "リクエストのパラメータが適切な場合、Shopのデータを返すこと",
			fields: fields{
				shopService: mock_service.NewMockShopService(ctrl),
			},
			want: want{
				body: &model.Shop{
					TotalHitCount: 1,
				},
				err: nil,
			},
			mockReturns: mockReturns{
				shop: &model.Shop{
					TotalHitCount: 1,
				},
				err: nil,
			},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			at, ok := tt.fields.shopService.(*mock_service.MockShopService)
			if !ok {
				t.Fatal("failed to assert MockShopService")
			}

			u := "http://localhost/shops/search?name=test"
			ctx := context.Background()
			parse, _ := url.Parse(u)
			param := parse.Query()

			at.EXPECT().GetShopList(ctx, param).Return(tt.mockReturns.shop, tt.mockReturns.err)

			ts := NewShopController(tt.fields.shopService)
			e := echo.New()
			e.GET("shops/search", ts.GetShopList)

			rec := httptest.NewRecorder()
			req, err := http.NewRequest(http.MethodGet, u, nil)
			if err != nil {
				t.Fatal(err)
			}
			e.ServeHTTP(rec, req)

			shop := &model.Shop{}
			err = json.Unmarshal(rec.Body.Bytes(), shop)
			if err != nil {
				t.Fatal(err)
			}
			if !reflect.DeepEqual(shop, tt.want.body) {
				t.Errorf("body = %#v, want %#v", shop, tt.want.body)
			}
		})
	}
}
