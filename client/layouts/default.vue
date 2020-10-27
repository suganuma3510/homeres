<template>
  <v-app :style="{ background: $vuetify.theme.themes[theme].background }">
    <Header />

    <v-main>
      <nuxt />
    </v-main>

    <v-footer :absolute="!fixed" app>
      <span>&copy; {{ new Date().getFullYear() }}</span>
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
