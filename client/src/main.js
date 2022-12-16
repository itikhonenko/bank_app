import Vue from 'vue';
import axios from 'axios';
import App from './App.vue'
import { router } from './router';
import store from './store';
import 'bootstrap';
import 'bootstrap/dist/css/bootstrap.min.css';
import VeeValidate from 'vee-validate';

axios.interceptors.response.use((response) => response, (error) => {
  if (error.response.status === 401) {
    store.dispatch('auth/logout')
    router.push('/login')
  }
  return Promise.reject(error)
})

Vue.use(VeeValidate);

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app');
