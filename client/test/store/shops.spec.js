import Vuex from 'vuex'
import * as shops from '@/store/shops'
import { createLocalVue } from '@vue/test-utils'

const localVue = createLocalVue()
localVue.use(Vuex)

describe('store/shops.js', () => {
  let store
  let shop1, shop2
  beforeEach(() => {
    store = new Vuex.Store(shops)
    shop1 = {
      id: '1',
      name: 'name_1',
      category: 'category_1'
    }
    shop2 = {
      id: '2',
      name: 'name_2',
      category: 'category_2'
    }
  })

  describe('getters', () => {
    let shops
    beforeEach(() => {
      shops = [shop1, shop2]
      store.replaceState({
        shops: shops,
        shop: shop1
      })
    })

    describe('shops', () => {
      test('statusがshopsのshopsが取得できること', () => {
        expect(store.getters['shops']).toContainEqual(shop1)
        expect(store.getters['shops']).toContainEqual(shop2)
      })
    })

    describe('shops_all', () => {
      test('すべてのshopsが取得できること', () => {
        expect(store.getters['shops']).toEqual(
          expect.arrayContaining(shops)
        )
      })
    })

    describe('shop', () => {
      test('shopが取得できること', () => {
        expect(store.getters['shop']).toBe(shop1)
      })
    })
  })
})
