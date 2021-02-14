<template>
  <div id="index-area">
    <v-row class="top_contents fill-height" justify="center" align="center">
      <v-col cols="12" sm="12" md="6" class="coll-left">
        <h1>HOME<br />RES</h1>
        <h2>Turn your house into a restaurant</h2>
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
    <ShopCardList />
    <ul class="list">
      <li class="item" v-for="(item, index) in this.items" :key="index">
        {{ item }}
      </li>
    </ul>
    <!--下スクロールした時に、次のページのデータを取得する無限スクロールコンポーネント-->
    <infinite-loading
      v-if="hasNext"
      @infinite="infiniteHandler"
      spinner="spiral"
      direction="bottom"
    >
      <div slot="no-more">No more</div>
      <!--これ以上表示するデータがない時に表示されるメッセージ-->
      <div slot="no-results">No results</div>
      <!--検索結果がない時に表示されるメッセージ-->
    </infinite-loading>
  </div>
</template>

<script>
import Logo from "~/components/Logo.vue";
import SearchForm from "~/components/search_form.vue";
import ShopCardList from "~/components/shop_card_list.vue";

export default {
  components: {
    Logo,
  },
  name: "InfiniteScroll",
  data() {
    return {
      items: [], // リストに表示するデータ
      startPage: 0, // 開始ページ番号
      endPage: 0, // 終了ページ番号
      totalPages: 0, // 総ページ数
      pageSize: 10, // １ページに表示するデータ件数
      initialized: false, // 初回データアクセスが完了した後にtrueを設定するフラグ
    };
  },
  computed: {
    hasNext() {
      return this.initialized && this.totalPages > this.endPage;
    },
  },
  mounted() {
    // 現在表示中のページ番号をURLに設定する為に、スクロールイベントを監視
    window.addEventListener("scroll", () => this.scroll());

    const urlParams = new URLSearchParams(window.location.search);
    const page = urlParams.get("page");

    if (page) {
      // URLパラメータでページ番号が指定された場合、指定ページから表示
      this.startPage = parseInt(page, 10);
      this.endPage = parseInt(page, 10);
    } else {
      // ページ番号の指定がない場合は１ページ目から表示
      this.startPage = 1;
      this.endPage = 1;
    }

    // 初回データアクセス
    this.getItems(null, this.startPage, false);
  },
  methods: {
    // スクロール時に、次ページに表示するデータを取得する処理
    infiniteHandler($state) {
      if (this.endPage >= this.totalPages) {
        // 表示するデータが無くなったら$state.complete()を呼ぶ
        $state.complete();
      } else {
        // 表示するデータがある場合、時ページのデータを読み込む
        this.getItems($state, this.endPage + 1, true);
      }
    },

    // ページに表示するデータを検索する処理
    getItems($state, page, next) {
      setTimeout(() => {
        // 読込データを設定（実際はaxiosなどで非同期でデータを取得する想定）
        let data = [];
        for (let i = 1; i <= this.pageSize; i++) {
          data.push(`item${page}-${i}`);
        }
        // 総ページ数を設定（これも実際はaxiosなどで非同期でデータを取得する想定）
        this.totalPages = 10;

        // 現在表示しているデータの末尾に取得したデータを追加
        this.items = this.items.concat(data);
        this.endPage = page;

        // $state.loaded()でデータの読込完了を通知する
        if ($state) $state.loaded();

        this.$nextTick(() => {
          this.initialized = true;
        });
      }, 1000);
    },

    // スクロールイベント発生時の処理
    scroll() {
      // 現在のスクロールY座標から、画面に表示されているページ番号を計算する
      let scroll_pos = window.pageYOffset || document.documentElement.scrollTop;
      let window_height = window.outerHeight;
      let page =
        Math.ceil((scroll_pos + 0.5 * window_height) / 40 / this.pageSize) +
        (this.startPage - 1);
      // replaceStateでurlを書き換え（urlパラメータにページ番号を設定）
      window.history.replaceState(null, null, "/?page=" + page);
    },
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