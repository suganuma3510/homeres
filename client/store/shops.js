import axios from 'axios'

export const state = () => ({
  isSearched: false,
  shopsTotalCount: 0,
  shops: [],
  shop: {},
  params: {}
})

export const getters = {
  isSearched: (state) => state.isSearched,
  shopsTotalCount: (state) => state.shopsTotalCount,
  shops: (state) => state.shops,
  shop: (state) => state.shop,
  params: (state) => state.params
}

export const mutations = {
  setIsSearched: (state) => state.isSearched = true,
  setShopsTotalCount: (state, shopsTotalCount) => {
    state.shopsTotalCount = shopsTotalCount
  },
  setShops: (state, shops) => {
    state.shops = shops
  },
  setShopInfo: (state, shop) => {
    state.shop = shop
  },
  setParams: (state, params) => {
    state.params = params
  },
}

export const actions = {
  async getShopList ({commit, state}) {
    this.$axios
        .$get("/api/shops/search", { params: state.params })
        .then((response) => {
          console.log("response data", response);
          commit("setShops", response.rest);
          commit("setShopsTotalCount", response.total_hit_count)
          commit("setIsSearched")
        })
        .catch((error) => {
          console.log("response error", error);
          commit("setShopsTotalCount", 0)
          commit("setIsSearched")
          return 0;
        });
  }
}