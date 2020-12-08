import Vuex from 'vuex'
import { mount, createLocalVue } from '@vue/test-utils'
import SearchForm from "@/components/search_form.vue";
import CategorySearch from "@/components/category_search.vue";

const localVue = createLocalVue()
localVue.use(Vuex)

describe('components/search_form.vue', () => {
  let wrapper
  beforeEach(() => {
    wrapper = mount(SearchForm, {
      localVue
    })
  })

  describe('template', () => {
    test('コンポーネントが表示されるか', () => {
      expect(wrapper.exists()).toBe(true)
      expect(wrapper.classes()).toContain('form-heading');
    })

    test('子コンポーネントが表示されるか', () => {
      expect(wrapper.find(".category-img").is(CategorySearch)).toBe(true)
    })
  })
})
