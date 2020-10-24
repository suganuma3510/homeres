<template>
  <div id="index-area">
    <v-row class="top_contents fill-height" justify="center" align="center">
      <v-col cols="12" sm="10" md="6" class="coll-left">
        <h1>HOME<br />RES</h1>
        <h2>Turn your house into a restaurant</h2>
      </v-col>

      <v-col cols="12" sm="10" md="6" class="coll-right repeating-gradient">
        <div class="text-center">
          <Logo />

          <p>
            本サービスは、デリバリーやテイクアウトを行っている飲食店のみを探し出し、<br />
            その飲食店のジャンルや、位置、営業情報などを提供するサービス。<br />
            『HOMERES(ホームレス)』とは、我が家で飲食店の食べ物を食べることができる、<br />
            『Home is restaurant』をコンセプトとしています。
          </p>
        </div>
      </v-col>
    </v-row>
  </div>
</template>

<script>
import Logo from "~/components/Logo.vue";

export default {
  components: {
    Logo,
  },
};
</script>
<style>
.top_contents {
  height: 100vh;
  background-image: url(../static/images/top_page_image.jpg);
}

.coll-left {
  margin-top: 5vh;
}

.coll-left h1 {
  font-size: 15vw;
  font-weight: 100;
  line-height: 0.7em;
  font-family: "Helvetica Neue", Arial, "Hiragino Kaku Gothic ProN",
    "Hiragino Sans", Meiryo, sans-serif;
}

.coll-left h2 {
  margin-top: 20px;
  margin-left: 0.2em;
  font-size: 5vw;
  font-weight: 100;
  line-height: 0.8em;
  font-family: "Helvetica Neue", Arial, "Hiragino Kaku Gothic ProN",
    "Hiragino Sans", Meiryo, sans-serif;
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
</style>