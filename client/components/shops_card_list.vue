<template>
  <v-container>
    <div class="shops-list">
      <v-card
        v-for="shop in shops"
        :key="shop.name"
        :loading="loading"
        class="mx-auto my-12"
        max-width="250"
      >
        <template slot="progress">
          <v-progress-linear
            color="deep-purple"
            height="10"
            indeterminate
          ></v-progress-linear>
        </template>

        <v-img height="250" :src="shop.image_url.shop_image1"></v-img>

        <v-card-title>{{ shop.name }}</v-card-title>

        <v-card-text>
          <v-row align="center" class="mx-0">
            <div class="grey--text ml-4" v-if="shop.access">
              {{ shop.code.prefname }}｜{{ shop.access.station }} から
              {{ shop.access.walk }} 分
            </div>
            <div class="grey--text ml-4" v-else>交通アクセス: 記載なし</div>
            <div class="grey--text ml-4" v-if="shop.budget">
              平均予算: ¥{{ shop.budget }}
            </div>
            <div class="grey--text ml-4" v-else>平均予算: 記載なし</div>
          </v-row>

          <div class="my-4 subtitle-1">{{ shop.category }}</div>
          <div>
            {{ shop.pr.pr_short }}
          </div>
        </v-card-text>

        <v-divider class="mx-4"></v-divider>
        <v-card-actions>
          <v-btn color="deep-purple lighten-2" text @click="reserve">
            詳細
          </v-btn>
        </v-card-actions>
      </v-card>
    </div>
  </v-container>
</template>
<script>
import { mapGetters, mapMutations } from "vuex";
export default {
  computed: {
    ...mapGetters({ shops: "shops/shops" }),
  },
};
</script>
<style>
.shops-list {
  display: flex;
  flex-wrap: wrap;
}
</style>