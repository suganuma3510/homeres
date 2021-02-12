<template>
  <v-app-bar
    :collapse="!collapseOnScroll"
    fixed
    flat
    color="transparent"
    dark
    v-bind:class="{ active: collapseOnScroll }"
  >
    <v-app-bar-nav-icon
      x-large
      v-on:mouseover="open"
      color="barcolor"
    ></v-app-bar-nav-icon>
    <v-toolbar-title class="header-title"
      ><nuxt-link to="/">HOMERES</nuxt-link></v-toolbar-title
    >
    <v-spacer></v-spacer>

    <v-toolbar-title class="switch-layout">
      <v-switch v-model="themeSwitch" @change="changeThemeColor"
        ><template v-slot:label>
          <v-icon color="barcolor">mdi-theme-light-dark</v-icon>
        </template></v-switch
      >
    </v-toolbar-title>

    <v-toolbar-title>
      <v-btn icon href="#form-heading">
        <v-icon v-on:click="close" color="barcolor">mdi-magnify</v-icon>
      </v-btn>
    </v-toolbar-title>

    <v-btn icon v-if="collapseOnScroll">
      <v-icon v-on:click="close" color="barcolor"
        >mdi-send mdi-rotate-180</v-icon
      >
    </v-btn>
  </v-app-bar>
</template>

<script>
export default {
  data: () => ({
    collapseOnScroll: true,
    themeSwitch: true,
  }),
  methods: {
    open() {
      this.collapseOnScroll = true;
    },
    close() {
      this.collapseOnScroll = false;
    },
    changeThemeColor() {
      // 色を変更している箇所
      this.$vuetify.theme.dark = this.themeSwitch;
    },
  },
};
</script>
<style>
.header-title a {
  text-decoration: none;
  color: white;
}
.switch-layout {
  padding: 20px 20px 0 10px;
}
</style>
