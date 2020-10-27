<template>
  <v-container>
    <v-row justify="space-between" style="height: 100vh">
      <v-col cols="12" md="6">
        <v-form ref="form">
          <v-text-field
            :counter="max"
            :rules="rules"
            label="エリア・駅"
            placeholder="例：渋谷、新宿駅"
            outlined
            clearable
            prepend-inner-icon="mdi-map-marker"
          ></v-text-field>
          <v-text-field
            :counter="max"
            :rules="rules"
            label="店名・ジャンル・目的"
            placeholder="例：イタリアン、居酒屋"
            outlined
            prepend-inner-icon="mdi-food"
          ></v-text-field>
        </v-form>
      </v-col>

      <v-col cols="12" md="4">
        <v-subheader>予算</v-subheader>

        <v-slider
          v-model="value"
          max="5000"
          step="500"
          thumb-label="always"
          ticks
          label="￥"
          prepend-icon="mdi-cash-100 mdi-36px"
        ></v-slider>

        <v-checkbox
          v-model="allowSpaces"
          label="デリバリー ・ テイクアウト のみ"
        ></v-checkbox>
      </v-col>
      <v-col cols="12" sm="6">
        <v-btn outlined x-large color="#EBCD51" block>
          <v-icon left dark>mdi-magnify mdi-24px</v-icon>検索
        </v-btn>
      </v-col>
      <v-col cols="12" sm="6">
        <v-btn outlined x-large color="#EBCD51" block>
          <v-icon left dark>mdi-map-marker-check mdi-24px</v-icon
          >現在地から近くを検索
        </v-btn>
      </v-col>

      <v-col v-for="n in 8" :key="n" class="d-flex child-flex" cols="3">
        <v-img
          :src="`images/category_list/category_list_image${n}.jpg`"
          :lazy-src="`images/category_list/category_list_image${n}.jpg`"
          aspect-ratio="1"
          style="max-height: 25vh"
        >
          <template v-slot:placeholder>
            <v-row class="fill-height ma-0" align="center" justify="center">
              <v-progress-circular
                indeterminate
                color="grey lighten-5"
              ></v-progress-circular>
            </v-row>
          </template>
        </v-img>
      </v-col>
    </v-row>
  </v-container>
</template>
<script>
export default {
  data: () => ({
    allowSpaces: true,
    match: "Foobar",
    max: 30,
    value: 500,
  }),

  computed: {
    rules() {
      const rules = [];

      if (this.max) {
        const rule = (v) =>
          (v || "").length <= this.max ||
          `A maximum of ${this.max} characters is allowed`;

        rules.push(rule);
      }

      if (!this.allowSpaces) {
        const rule = (v) =>
          (v || "").indexOf(" ") < 0 || "No spaces are allowed";

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
    validateField() {
      this.$refs.form.validate();
    },
  },
};
</script>
<style>
</style>