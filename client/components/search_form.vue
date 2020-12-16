<template>
  <v-container>
    <h3 id="form-heading">キーワード・ジャンル から探す</h3>
    <v-row class="row-area">
      <v-col cols="12" class="col-area text-center">
        <v-text-field
          v-model="freeword"
          :counter="max"
          :rules="rules"
          label="店名・ジャンル・目的"
          placeholder="例：イタリアン、居酒屋"
          outlined
          clearable
          prepend-inner-icon="mdi-food"
          class="form-area form-text"
        >
          <template v-slot:append-outer> </template>
        </v-text-field>
        <v-text-field
          v-model="area"
          :counter="max"
          :rules="rules"
          label="エリア・駅"
          placeholder="例：渋谷、新宿駅"
          outlined
          clearable
          prepend-inner-icon="mdi-map-marker"
          class="form-area form-text"
        >
        </v-text-field>
        <div class="form-area form-checkbox">
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
          v-on:click="getShops"
          @click="getShops"
          outlined
          color="#EBCD51"
          x-large
          class="form-area form-btn"
        >
          <v-icon left dark>mdi-magnify mdi-24px</v-icon>検索
        </v-btn>
      </v-col>
      <v-col v-for="c in category" :key="c" class="col-area" cols="6" sm="3">
        <CategorySearch
          v-bind:category="c"
          v-bind:deliverly="deliverly"
          v-bind:takeout="takeout"
        />
      </v-col>
    </v-row>
  </v-container>
</template>
<script>
import CategorySearch from "~/components/category_search.vue";
import { mapGetters, mapMutations } from "vuex";

export default {
  data: () => ({
    match: "Foobar",
    max: 30,
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
  },

  computed: {
    ...mapGetters({ shops: "shops/shops" }),
    rules() {
      const rules = [];
      if (this.max) {
        const rule = (v) =>
          (v || "").length <= this.max ||
          `${this.max} 文字以下で入力してください`;

        rules.push(rule);
      }
      return rules;
    },
  },

  watch: {
    match: "validateField",
    max: "validateField",
  },

  methods: {
    ...mapMutations({ setShops: "shops/setShops" }),
    validateField() {
      this.$refs.form.validate();
    },
    getShops() {
      this.$axios
        .$get("/api/shops/search", {
          params: {
            freeword: this.freeword + this.area,
            deliverly: this.deliverly,
            takeout: this.takeout,
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
#form-heading {
  padding: 15px;
  margin: 3vh 0 -20px;
  text-align: center;
}
.row-area {
  height: 100vh;
  padding: 3vw 0 0;
}
.form-area {
  display: inline-block;
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

@media (min-width: 0px) and (max-width: 600px) {
  #form-heading {
    padding: 12px;
    margin: 0;
  }
  .row-area {
    padding: 3px;
  }
  .col-area {
    padding: 0 5px 0;
    margin: 0 0 0;
  }
  .form-text {
    min-width: 500px;
  }
}
</style>