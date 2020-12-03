import Vuex from 'vuex'
import * as shops from '@/store/shops'
import {
  createLocalVue
} from '@vue/test-utils'

const localVue = createLocalVue()
localVue.use(Vuex)

describe('store/index.js', () => {
  let store
  let shops1, shops2
  beforeEach(() => {
    store = new Vuex.Store(shops)
    shops1 = {
      id: '1',
      name: 'name_1',
      category: 'category_1'
    }
    shops2 = {
      id: '2',
      name: 'name_2',
      category: 'category_2'
    }
  })

  describe('getters', () => {
    let shops
    beforeEach(() => {
      shops = [shops1, shops2]
      store.replaceState({
        shops: shops
      })
    })

    describe('shops', () => {
      test('statusがshopsのshopsが取得できること', () => {
        expect(store.getters['shops']).toContainEqual(shops1)
        expect(store.getters['shops']).toContainEqual(shops2)
      })
    })
  })
})
