<template>
  <v-hover v-slot="{ hover }">
    <v-img
      :src="`images/category_list/${category}_img.jpg`"
      :lazy-src="`images/category_list/${category}_img.jpg`"
      aspect-ratio="1"
      class="category-img"
    >
      <a @click="getShops">
        <v-expand-transition>
          <div
            v-if="hover"
            class="d-flex transition-fast-in-fast-out v-card--reveal white--text"
            style="height: 100%"
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
</template>
<script>
import { mapGetters, mapMutations } from "vuex";

export default {
  props: ["category", "takeout", "deliverly"],
  methods: {
    ...mapMutations({
      setShops: "shops/setShops",
    }),
    validateField() {
      this.$refs.form.validate();
    },
    getShops() {
      this.$axios
        .$get("/api/shops/search", {
          params: {
            freeword: this.$props.category,
            deliverly: this.$props.deliverly,
            takeout: this.$props.takeout,
          },
        })
        .then((response) => {
          console.log("response data", response);
          this.setShops(response.rest);
        })
        .catch((error) => {
          console.log("response error", error);
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
  font-size: 3vw;
  align-items: center;
  bottom: 0;
  justify-content: center;
  background-color: #ebcd51aa;
  position: absolute;
  width: 100%;
}

@media (min-width: 0px) and (max-width: 600px) {
  .category-img {
    max-height: 14vh;
  }
}
</style>