export const state = () => ({
  shops: [],
})

export const getters = {
  shops: (state) => state.shops,
}

export const mutations = {
  setShops: (state, shops) => {
    state.shops = shops
  }
}
