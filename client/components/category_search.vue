<template>
  <div id="category-search-area">
    <v-hover v-slot="{ hover }">
      <v-img
        :src="`images/category_list/${category}_img.jpg`"
        :lazy-src="`images/category_list/${category}_img.jpg`"
        aspect-ratio="1"
        @click="getShops"
        class="category-img"
      >
        <a @click="getShops">
          <v-expand-transition>
            <div
              v-if="hover"
              class="d-flex transition-fast-in-fast-out v-card--reveal white--text"
            >
              {{ category }}
            </div>
          </v-expand-transition>
        </a>
        <template v-slot:placeholder>
          <v-row class="fill-height ma-0" align="center" justify="center">
            <v-progress-circular
              indeterminate
              color="grey lighten-5"
            ></v-progress-circular>
          </v-row>
        </template>
      </v-img>
    </v-hover>
    <v-snackbar v-model="snackbar">
      該当する飲食店は、ありませんでした。再度検索してみてください。
    </v-snackbar>
  </div>
</template>
<script>
import { mapGetters, mapMutations } from "vuex";

export default {
  props: ["category", "area", "takeout", "deliverly"],
  data: () => ({
    snackbar: false,
  }),
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
    validateField() {
      this.$refs.form.validate();
    },
    getShops() {
      var area;
      if (this.$props.area == null) {
        area = "";
      } else {
        area = this.$props.area.replace(/\s+/g, ",");
      }
      this.setParams({
        freeword: this.$props.category + "," + area,
        deliverly: this.$props.deliverly,
        takeout: this.$props.takeout,
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
.category-img {
  max-height: 30vh;
  margin: -50px 0 -30px;
}
.v-card--reveal {
  height: 100%;
  font-size: 1.2em;
  align-items: center;
  bottom: 0;
  justify-content: center;
  background-color: #ebcd51aa;
  position: absolute;
  width: 100%;
}

@media (min-width: 0px) and (max-width: 650px) {
  .category-img {
    max-height: 15vh;
  }
}
@media (min-width: 0px) and (max-width: 450px) {
  .category-img {
    max-height: 12.5vh;
  }
}
</style>