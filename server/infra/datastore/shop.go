package datastore

import (
	"os"
	"fmt"
	"log"
	"net/url"
	"context"
	"net/http"
	"io/ioutil"
	"encoding/json"
	"github.com/joho/godotenv"
	"github.com/suganuma3510/homeres/domain/model"
	"github.com/suganuma3510/homeres/domain/repository"
)

type shopRepository struct{}

func NewShopRepository() repository.ShopRepository {
	return &shopRepository{}
}

const (
	ENDPOINT = "https://api.gnavi.co.jp/RestSearchAPI/v3/"
)

// GetShopList : ぐるなびAPIから飲食店情報を取得
func (sr shopRepository) GetShopList(context.Context) (*model.Shop, error) {

	// .envファイル読み込み
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}
	keyid := os.Getenv("ACCESS_KEY")

	// URLパース
	url, err := url.Parse(ENDPOINT)
	if err != nil {
		fmt.Println(err)
	}

	// Queryメソッドでクエリパラメータのマップを取得
	q := url.Query()

	// クエリマップに値をセット
	q.Set("keyid", keyid)
	q.Set("name", "sushi")

	// クエリパラメータをエンコード
	url.RawQuery = q.Encode()

	// ぐるなびAPIを叩く
	resp, err := http.Get(url.String())

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
