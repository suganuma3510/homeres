<template>
  <v-container>
    <h3 id="form-heading">キーワード・ジャンル から探す</h3>
    <v-row class="row-area" justify="center">
      <v-col cols="12" class="col-area text-center">
        <v-text-field
          v-model="freeword"
          counter
          maxlength="25"
          label="店名・ジャンル・目的"
          placeholder="例：イタリアン、居酒屋"
          outlined
          clearable
          prepend-inner-icon="mdi-food"
          style="display: inline-block"
          class="form-text"
        >
          <template v-slot:append-outer> </template>
        </v-text-field>
        <v-text-field
          v-model="area"
          counter
          maxlength="25"
          label="エリア・駅"
          placeholder="例：渋谷、新宿駅"
          outlined
          clearable
          prepend-inner-icon="mdi-map-marker"
          style="display: inline-block"
          class="form-text"
        >
        </v-text-field>
        <div class="form-checkbox" style="display: inline-block">
          <v-checkbox
            v-model="deliverly"
            true-value="1"
            false-value="0"
            label="デリバリー 可"
            hide-details
            class="shrink mr-2 mt-0"
          ></v-checkbox>
          <v-checkbox
            v-model="takeout"
            true-value="1"
            false-value="0"
            label="テイクアウト 可"
            hide-details
            class="shrink mr-2 mt-0"
          ></v-checkbox>
        </div>
        <v-btn
          @click="getShops"
          outlined
          color="primary"
          x-large
          class="form-area form-btn"
        >
          <v-icon left dark>mdi-magnify mdi-24px</v-icon>検索
        </v-btn>
      </v-col>
      <v-col
        v-for="c in category"
        :key="c"
        class="col-area"
        cols="6"
        lg="3"
        sm="3"
        xs="6"
      >
        <CategorySearch
          v-bind:category="c"
          v-bind:area="area"
          v-bind:deliverly="deliverly"
          v-bind:takeout="takeout"
        />
      </v-col>
    </v-row>

    <ShopCardList />
    <v-snackbar v-model="snackbar">
      該当する飲食店は、ありませんでした。再度検索してみてください。
    </v-snackbar>
  </v-container>
</template>
<script>
import CategorySearch from "~/components/category_search.vue";
import ShopCardList from "~/components/shop_card_list.vue";
import { mapGetters, mapMutations } from "vuex";

export default {
  data: () => ({
    snackbar: false,
    freeword: "",
    area: "",
    deliverly: "1",
    takeout: "1",
    category: [
      "和食",
      "イタリアン",
      "中華",
      "フレンチ",
      "寿司",
      "ラーメン",
      "スイーツ",
      "ファーストフード",
    ],
  }),

  components: {
    CategorySearch,
    ShopCardList,
  },

  computed: {
    ...mapGetters({
      shopsTotalCount: "shops/shopsTotalCount",
      shops: "shops/shops",
      params: "shops/params",
    }),
  },

  methods: {
    ...mapMutations({
      setIsSearched: "shops/setIsSearched",
      setShopsTotalCount: "shops/setShopsTotalCount",
      setShops: "shops/setShops",
      setParams: "shops/setParams",
    }),
    getShops() {
      if (this.freeword == null) {
        this.freeword = "";
      }
      if (this.area == null) {
        this.area = "";
      }
      this.setParams({
        freeword: this.freeword.replace(/\s+/g, ",") + "," + this.area.replace(/\s+/g, ","),
        deliverly: this.deliverly,
        takeout: this.takeout,
      });
      this.$axios
        .$get("/api/shops/search", { params: this.params })
        .then((response) => {
          console.log("response data", response);
          if (response.total_hit_count != 0) {
            this.setShops(response.rest);
            this.setShopsTotalCount(response.total_hit_count);
          } else {
            this.snackbar = true;
          }
          this.setIsSearched();
        })
        .catch((error) => {
          console.log("response error", error);
          this.snackbar = true;
        });
    },
  },
};
</script>
<style>
#form-heading {
  padding: 15px;
  margin: 3vh 0 -20px;
  text-align: center;
}
.row-area {
  height: 100vh;
  padding: 3vw 0 0;
}
.form-text {
  width: 20vw;
}
.form-checkbox {
  vertical-align: -14px;
  padding: 0;
  margin-bottom: -10px;
}
.form-btn {
  vertical-align: 1px;
  padding: 0;
  margin-bottom: -10px;
}

@media (min-width: 0px) and (max-width: 450px) {
  #form-heading {
    padding: 12px;
    margin: 0;
  }
  .row-area {
    padding: 3px;
  }
  .col-area {
    padding: 0 5px 0;
    margin: 0;
  }
  .form-text {
    min-width: 300px;
  }
}
</style>