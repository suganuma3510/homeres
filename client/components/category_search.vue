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
  </div>
</template>
<script>
import { mapGetters, mapMutations, mapActions } from "vuex";

export default {
  props: ["category", "area", "takeout", "deliverly"],
  computed: {
    ...mapGetters({
      shops: "shops/shops",
      params: "shops/params",
    }),
  },
  methods: {
    ...mapMutations({
      setIsSearched: "shops/setIsSearched",
      setParams: "shops/setParams",
    }),
    ...mapActions({
      getShopList: "shops/getShopList",
    }),
    validateField() {
      this.$refs.form.validate();
    },
    getShops() {
      if (this.$props.area == null) area = "";
      var searchWord;
      searchWord = this.$props.category + "," + this.$props.area.replace(/\s+/g, ",");
      this.setParams({
        freeword: searchWord,
        deliverly: this.$props.deliverly,
        takeout: this.$props.takeout,
      });
      this.getShopList();
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