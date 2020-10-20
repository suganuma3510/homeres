<template>
  <div id="index-area">
    <v-row class="top_contents fill-height" justify="center" align="center">
      <v-col cols="12" sm="8" md="6">
        <div class="text-center">
          <h1>HOMERES</h1>
          <Logo />
          <h2>Turn your house into a restaurant</h2>
          <div class="text-contents repeating-gradient">
            <p>
              本サービスは、デリバリーやテイクアウトを行っている飲食店のみを探し出し、
              その飲食店のジャンルや、位置、営業情報などを提供するサービス。<br />
              『HOMERES(ホームレス)』とは、我が家で飲食店の食べ物を食べることができる、
              『Home is restaurant』をコンセプトとしています。
            </p>
          </div>
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

.text-center h1 {
  font-size: 7.5vw;
  font-weight: 100;
  font-family: "Helvetica Neue", Arial, "Hiragino Kaku Gothic ProN",
    "Hiragino Sans", Meiryo, sans-serif;
}

.text-center h2 {
  font-weight: 100;
  font-family: "Helvetica Neue", Arial, "Hiragino Kaku Gothic ProN",
    "Hiragino Sans", Meiryo, sans-serif;
}

.text-contents {
  padding: 40px 40px 20px 40px;
  margin: 25px;
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