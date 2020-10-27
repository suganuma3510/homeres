<template>
  <v-app-bar
    :collapse="!collapseOnScroll"
    fixed
    flat
    color="transparent"
    dark
    v-bind:class="{ active: collapseOnScroll }"
  >
  
    <v-app-bar-nav-icon x-large v-on:mouseover="open"></v-app-bar-nav-icon>
    <v-toolbar-title>HOMERES</v-toolbar-title>

    <v-spacer></v-spacer>
    <v-toolbar-title>
      <v-btn icon>
        <v-icon>mdi-magnify</v-icon>
      </v-btn>
    </v-toolbar-title>

    <v-btn icon  v-if="collapseOnScroll" >
      <v-icon v-on:click="close">mdi-send mdi-rotate-180</v-icon>
    </v-btn>
  </v-app-bar>
</template>

<script>
export default {
  data: () => ({
    collapseOnScroll: true,
  }),
  methods: {
    open() {
      this.collapseOnScroll = true;
    },
    close() {
      this.collapseOnScroll = false;
    },
  },
};
</script>
<style>
.active {
  margin: 0 8vw;
}
</style>
