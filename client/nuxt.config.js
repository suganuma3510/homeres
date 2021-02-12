import colors from 'vuetify/es5/util/colors'

export default {
  // Global page headers (https://go.nuxtjs.dev/config-head)
  head: {
    titleTemplate: '%s - homeres',
    title: 'homeres',
    meta: [{
        charset: 'utf-8'
      },
      {
        name: 'viewport',
        content: 'width=device-width, initial-scale=1'
      },
      {
        hid: 'description',
        name: 'description',
        content: ''
      }
    ],
    link: [{
      rel: 'icon',
      type: 'image/x-icon',
      href: '/favicon.ico'
    }]
  },

  // Global CSS (https://go.nuxtjs.dev/config-css)
  css: [],

  // Plugins to run before rendering page (https://go.nuxtjs.dev/config-plugins)
  plugins: [
    'plugins/axios'
  ],

  // Auto import components (https://go.nuxtjs.dev/config-components)
  components: true,

  // Modules for dev and build (recommended) (https://go.nuxtjs.dev/config-modules)
  buildModules: [
    // https://go.nuxtjs.dev/vuetify
    '@nuxtjs/vuetify',
  ],

  // Modules (https://go.nuxtjs.dev/config-modules)
  modules: [
    // https://go.nuxtjs.dev/axios
    '@nuxtjs/axios',
    '@nuxtjs/proxy'
  ],

  // Axios module configuration (https://go.nuxtjs.dev/config-axios)
  axios: {
    proxy: true
  },
  proxy: {
    '/api/': process.env.NODE_ENV !== 'production' ?
      {
        target: 'http://server:3000/',
        pathRewrite: { '^/api/': '/' }
      } :
      {
        target: 'http://www.homeres.info:3000/',
        pathRewrite: { '^/api/': '/' }
      }
  },

  // Vuetify module configuration (https://go.nuxtjs.dev/config-vuetify)
  vuetify: {
    customVariables: ['~/assets/variables.scss'],
    theme: {
      dark: true,
      themes: {
        light: {
          primary: "#4E342E",
          secondary: "#EBCD51",
          accent: "#48B0C7",
          error: "#ffeb3b",
          warning: "#ffc107",
          info: "#ff5722",
          success: "#795548",
          background: "#FFF9C4",
          barcolor: "#4E342E",
        },
        dark: {
          primary: "#EBCD51",
          secondary: "#F0ADA7",
          accent: "#559CB6",
          error: "#ffeb3b",
          warning: "#ffc107",
          info: "#ff5722",
          success: "#795548",
          background: "#5D4037",
          barcolor: "#ffffff",
        }
      }
    }
  },

  // Build Configuration (https://go.nuxtjs.dev/config-build)
  build: {}
}
