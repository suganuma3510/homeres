import Vuex from 'vuex'
import { shallowMount, createLocalVue } from '@vue/test-utils'
import SearchForm from "@/components/search_form.vue";

const localVue = createLocalVue()
localVue.use(Vuex)

describe('components/search_form.vue', () => {
  let wrapper
  beforeEach(() => {
    wrapper = shallowMount(SearchForm, {
      localVue
    })
  })

  describe('template', () => {
    test('コンポーネントが表示されるか', () => {
      expect(wrapper.exists()).toBe(true)
    })
  })
})
