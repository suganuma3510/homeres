<template>
  <div id="index-area">
    <v-row class="top_contents fill-height white--text" justify="center" align="center">
      <v-col cols="12" sm="12" md="6" class="coll-left">
        <h1>HOME<br />RES</h1>
        <h2>Turn your home into a restaurant</h2>
      </v-col>

      <v-col cols="12" sm="10" md="6" class="coll-right repeating-gradient">
        <div class="text-center">
          <Logo />
          <p class="font-weight-bold">
            本サービスは、デリバリーやテイクアウトを行っている飲食店のみを探し出し、<br />
            その飲食店のジャンルや、位置、営業情報などを提供するサービスです。<br />
          </p>
          <v-btn href="#form-heading" color="#F9A825" large>
            <v-icon left dark>mdi-magnify mdi-24px</v-icon>let's serach !
          </v-btn>
        </div>
      </v-col>
    </v-row>
    <SearchForm />
  </div>
</template>

<script>
import Logo from "~/components/Logo.vue";
import SearchForm from "~/components/search_form.vue";

export default {
  components: {
    Logo,
    SearchForm,
  },
};
</script>
<style>
.top_contents {
  height: 100vh;
  width: 103%;
  background-image: url(../static/images/top_page_image.jpg);
  background-size: cover;
}
.coll-left {
  margin-top: 5vh;
}
.coll-left h1 {
  font-size: 15vw;
  font-weight: 400;
  line-height: 0.7em;
}
.coll-left h2 {
  margin-top: 20px;
  margin-left: 0.2em;
  font-size: 5vw;
  font-weight: 400;
  line-height: 0.8em;
}
.repeating-gradient {
  background-image: repeating-linear-gradient(
    -45deg,
    rgba(255, 0, 0, 0.25),
    rgba(255, 0, 0, 0.25) 5px,
    rgba(0, 0, 255, 0.25) 5px,
    rgba(0, 0, 255, 0.25) 10px
  );
}

@media (min-width: 0px) and (max-width: 450px) {
  .coll-left h1 {
    font-size: 30vw;
  }
  .coll-left h2 {
    font-size: 10vw;
  }
}
</style>