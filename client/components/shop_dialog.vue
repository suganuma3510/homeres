<template>
  <v-row justify="center">
    <v-dialog
      v-model="dialog"
      fullscreen
      hide-overlay
      transition="dialog-bottom-transition"
    >
      <v-card>
        <v-toolbar dark color="#F9A825">
          <v-toolbar-title
            ><h3>{{ shop.name }}</h3></v-toolbar-title
          >
          <v-spacer></v-spacer>
          <v-toolbar-items>
            <v-btn dark text @click="dialogClose"> 閉じる </v-btn>
          </v-toolbar-items>
        </v-toolbar>

        <v-img :src="shop.image_url.shop_image1" class="shop-img"></v-img>
        <v-img :src="shop.image_url.shop_image2" class="shop-img"></v-img>
        <v-card-title>{{ shop.category }}</v-card-title>

        <v-card-text>
          <div v-if="shop.pr.pr_long">
            <div class="my-4 subtitle-1">こだわり</div>
            <div class="ml-4">{{ shop.pr.pr_long }}</div>
          </div>

          <div class="my-4 subtitle-1">営業情報</div>
          <div class="ml-4">
            <div>営業時間</div>
            <div v-if="shop.opentime">{{ shop.opentime }}</div>
            <div v-else>サイトHPにてご確認下さい</div>
            <br />
            <div>休業日</div>
            <div v-if="shop.opentime">{{ shop.holiday }}</div>
            <div v-else>サイトHPにてご確認下さい</div>
            <br />
            <div>予算</div>
            <span v-if="shop.lunch">昼：{{ shop.lunch }}円　</span>
            <span v-if="shop.budget">夜：{{ shop.budget }}円　</span>
            <span v-if="shop.party">宴会：{{ shop.party }}円　</span>
          </div>

          <div class="my-4 subtitle-1">アクセス</div>
          <div class="ml-4">
            <div v-if="shop.address">{{ shop.address }}</div>
            <div v-if="shop.access">
              {{ shop.code.prefname }}｜{{ shop.access.station }} から
              {{ shop.access.walk }} 分
            </div>
            <br />
            <div v-if="shop.tel">電話番号：{{ shop.tel }}</div>
            <div v-if="shop.url">
              サイトURL：<a :href="shop.url" target="_blank">{{ shop.url }}</a>
            </div>
          </div>
        </v-card-text>
      </v-card>
    </v-dialog>
  </v-row>
</template>
<script>
import { mapGetters, mapMutations } from "vuex";

export default {
  props: {
    dialog: false,
  },
  data() {
    return {
      notifications: false,
      sound: true,
      widgets: false,
    };
  },
  computed: {
    ...mapGetters({ shop: "shops/shop" }),
  },
  methods: {
    dialogClose() {
      this.$emit("onDialog");
    },
  },
};
</script>
<style>
.shop-img {
  height: 250px;
  width: 250px;
  display: inline-block;
}
</style>