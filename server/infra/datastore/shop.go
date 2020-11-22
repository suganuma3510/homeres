package datastore

import (
	"context"
	"encoding/json"
	"fmt"
	"github.com/joho/godotenv"
	"github.com/suganuma3510/homeres/domain/model"
	"github.com/suganuma3510/homeres/domain/repository"
	"io/ioutil"
	"log"
	"net/http"
	"net/url"
	"os"
)

type shopRepository struct{}

func NewShopRepository() repository.ShopRepository {
	return &shopRepository{}
}

const (
	ENDPOINT = "https://api.gnavi.co.jp/RestSearchAPI/v3/"
)

// GetShopList : ぐるなびAPIから飲食店情報を取得
func (sr shopRepository) GetShopList(ctx context.Context, param url.Values) (*model.Shop, error) {

	// .envファイル読み込み
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}
	keyid := os.Getenv("ACCESS_KEY")

	// URLパース
	u, err := url.Parse(ENDPOINT)
	if err != nil {
		fmt.Println(err)
	}

	// APIアクセスキー追加
	param.Add("keyid", keyid)
	u.RawQuery = param.Encode()

	// ぐるなびAPIを叩く
	resp, err := http.Get(u.String())
	if err != nil {
		log.Fatal(err)
	}

	defer resp.Body.Close()
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		fmt.Println(err)
	}

	var ev model.Shop
	json.Unmarshal(body, &ev)

	return &ev, nil
}
