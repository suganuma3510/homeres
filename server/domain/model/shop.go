package model

import "time"

type Shop struct {
	TotalHitCount int `json:"total_hit_count"`
	HitPerPage    int `json:"hit_per_page"`
	PageOffset    int `json:"page_offset"`

	RestaurantList []Restaurant `json:"rest"`
}

type Restaurant struct {
	ID          string    `json:"id"`
	UpdateDate  time.Time `json:"update_date"`
	Name        string    `json:"name"`
	NameKana    string    `json:"name_kana"`
	Latitude    string    `json:"latitude"`
	Longitude   string    `json:"longitude"`
	Category    string    `json:"category"`
	URL         string    `json:"url"`
	URLMobile   string    `json:"url_mobile"`
	Address     string    `json:"address"`
	Tel         string    `json:"tel"`
	TelSub      string    `json:"tel_sub"`
	Fax         string    `json:"fax"`
	Opentime    string    `json:"opentime"`
	Holiday     string    `json:"holiday"`
	Budget      int       `json:"budget"`
	Party       int       `json:"party"`
	Lunch       int       `json:"lunch"`
	CreditCard  string    `json:"credit_card"`
	EMoney      string    `json:"e_money"`
	ParkingLots string    `json:"parking_lots"`

	ImageURL ImageURL `json:"image_url"`
	Access   Access   `json:"access"`
	Code     Code     `json:"code"`
	Pr       Pr       `json:"pr"`
}

type ImageURL struct {
	ShopImage1 string `json:"shop_image1"`
	ShopImage2 string `json:"shop_image2"`
	Qrcode     string `json:"qrcode"`
}

type Access struct {
	Line        string `json:"line"`
	Station     string `json:"station"`
	StationExit string `json:"station_exit"`
	Walk        string `json:"walk"`
	Note        string `json:"note"`
}

type Code struct {
	Areacode      string   `json:"areacode"`
	Areaname      string   `json:"areaname"`
	Prefcode      string   `json:"prefcode"`
	Prefname      string   `json:"prefname"`
	AreacodeS     string   `json:"areacode_s"`
	AreanameS     string   `json:"areaname_s"`
	CategoryCodeL []string `json:"category_code_l"`
	CategoryNameL []string `json:"category_name_l"`
	CategoryCodeS []string `json:"category_code_s"`
	CategoryNameS []string `json:"category_name_s"`
}

type Pr struct {
	PrShort string `json:"pr_short"`
	PrLong  string `json:"pr_long"`
}
