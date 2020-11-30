export const state = () => ({
  shops: [],
  shop: {}
})

export const getters = {
  shops: (state) => state.shops,
  shop: (state) => state.shop
}

export const mutations = {
  setShops: (state, shops) => {
    state.shops = shops
  },
  setShopInfo: (state, shop) => {
    state.shop = shop
  }
}
