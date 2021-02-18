<template>
  <div v-if="isSearched">
    <h2 class="hit-count-label" v-if="shops.length != 0">
      全 {{ shopsTotalCount }} 件
    </h2>
    <div v-if="shops.length != 0">
      <div class="shops-list">
        <v-card
          v-for="(shop, index) in shops"
          :key="index"
          class="mx-auto my-12"
          max-width="250"
          @click="showShopInfo(shop)"
        >
          <template slot="progress">
            <v-progress-linear
              color="deep-purple"
              height="10"
              indeterminate
            ></v-progress-linear>
          </template>

          <v-img
            height="250"
            :src="shop.image_url.shop_image1"
            v-if="shop.image_url.shop_image1"
          ></v-img>
          <v-img
            height="250"
            :src="shop.image_url.shop_image2"
            v-else-if="shop.image_url.shop_image2"
          ></v-img>
          <v-img height="250" :src="'images/no_image.png'" v-else></v-img>

          <v-card-title>{{ shop.name }}</v-card-title>

          <v-card-text>
            <v-row align="center" class="mx-0">
              <div class="grey--text ml-4" v-if="shop.access">
                {{ shop.code.prefname }}｜{{ shop.access.station }} から
                {{ shop.access.walk }} 分
              </div>
              <div class="grey--text ml-4" v-else>交通アクセス: 記載なし</div>
            </v-row>

            <div class="my-4 subtitle-1">{{ shop.category }}</div>
            <div>
              {{ shop.pr.pr_short }}
            </div>
          </v-card-text>

          <v-divider class="mx-4"></v-divider>
          <v-card-actions>
            <v-btn color="primary" text> 詳細 </v-btn>
          </v-card-actions>
        </v-card>
      </div>

      <!--飲食店詳細表示コンポーネント-->
      <ShopDialog :dialog="dialog" @onDialog="onDialog(false)" v-if="dialog" />

      <!--下スクロールした時に、次のページのデータを取得する無限スクロールコンポーネント-->
      <infinite-loading
        @infinite="infiniteHandler"
        spinner="waveDots"
        direction="bottom"
      >
        <!--これ以上表示するデータがない時に表示されるメッセージ-->
        <h3 slot="no-more">すべてのページを表示しました</h3>
        <h3 slot="no-results">すべてのページを表示しました</h3>
      </infinite-loading>
    </div>
  </div>
</template>
<script>
import ShopDialog from "~/components/shop_dialog.vue";
import { mapGetters, mapMutations } from "vuex";

export default {
  data() {
    return {
      dialog: false,
      offsetPage: 11, // 開始ページ番号
    };
  },
  name: "InfiniteScroll",
  components: {
    ShopDialog,
  },
  computed: {
    ...mapGetters({
      isSearched: "shops/isSearched",
      shopsTotalCount: "shops/shopsTotalCount",
      shops: "shops/shops",
      params: "shops/params",
    }),
  },
  methods: {
    ...mapMutations({
      setShops: "shops/setShops",
      setShopInfo: "shops/setShopInfo",
    }),
    validateField() {
      this.$refs.form.validate();
    },
    showShopInfo(shop) {
      this.onDialog(true);
      this.setShopInfo(shop);
    },
    onDialog(bool) {
      this.dialog = bool;
    },

    // スクロール時に、次ページに表示するデータを取得する処理
    infiniteHandler($state) {
      if (this.offsetPage >= this.shopsTotalCount) {
        $state.complete();
      } else {
        this.getItems($state, this.offsetPage);
      }
    },

    // ページに表示するデータを検索する処理
    getItems($state, Page) {
      // ぐるなびAPIから追加の飲食店情報を取得
      this.$axios
        .$get("/api/shops/search", {
          params: {
            offset: Page,
            freeword: this.params.freeword,
            deliverly: this.params.deliverly,
            takeout: this.params.takeout,
          },
        })
        .then((response) => {
          console.log("response error", response);
          this.setShops(this.shops.concat(response.rest));
          this.offsetPage += 10;

          // $state.loaded()でデータの読込完了を通知する
          if ($state) $state.loaded();
        })
        .catch((error) => {
          console.log("response error", error);
          $state.complete();
        });
    },
  },
};
</script>
<style>
.shops-list {
  display: flex;
  flex-wrap: wrap;
}
</style>