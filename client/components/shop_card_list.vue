<template>
  <v-container>
    <div class="shops-list" v-if="shops != null">
      <v-card
        v-for="shop in shops"
        :key="shop.name"
        :loading="loading"
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
      <ShopDialog :dialog="dialog" @onDialog="onDialog(false)" v-if="dialog" />
    </div>
  </v-container>
</template>
<script>
import ShopDialog from "~/components/shop_dialog.vue";
import { mapGetters, mapMutations } from "vuex";
export default {
  data() {
    return {
      dialog: false,
    };
  },
  components: {
    ShopDialog,
  },
  computed: {
    ...mapGetters({ shops: "shops/shops" }),
  },
  methods: {
    showShopInfo(shop) {
      this.onDialog(true);
      this.setShopInfo(shop);
    },
    onDialog(bool) {
      this.dialog = bool;
    },
    ...mapMutations({ setShopInfo: "shops/setShopInfo" }),
  },
};
</script>
<style>
.shops-list {
  display: flex;
  flex-wrap: wrap;
}
</style>