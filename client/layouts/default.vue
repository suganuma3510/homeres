<template>
  <v-app :style="{ background: $vuetify.theme.themes[theme].background }">
    <Header />

    <v-main>
      <nuxt />
    </v-main>

    <v-footer padless>
      <v-col class="text-center" cols="12">
        &copy;{{ new Date().getFullYear() }} — <strong>HOMERES</strong>
      </v-col>
    </v-footer>
  </v-app>
</template>

<script>
import Header from "~/components/header.vue";

export default {
  name: "App",
  computed: {
    theme() {
      return this.$vuetify.theme.dark ? "dark" : "light";
    },
  },
};
</script>
