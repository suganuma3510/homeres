<template>
  <v-app-bar
    :collapse="!collapseOnScroll"
    v-on:mouseover="open"
    v-on:mouseleave="collapse"
    app
    flat
    color="transparent"
    dark
  >
  <v-container>
    <v-app-bar-nav-icon></v-app-bar-nav-icon>

    <v-toolbar-title>Collapsing Bar</v-toolbar-title>
</v-container>
  </v-app-bar>
  
</template>
<script>
export default {
  data: () => ({
    collapseOnScroll: false,
  }),
  methods: {
    open() {
      this.collapseOnScroll = true;
    },
    collapse() {
      this.collapseOnScroll = false;
    },
  },
};
</script>
