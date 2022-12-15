import Vue from 'vue';
import Router from 'vue-router';
import VueLogin from './views/VueLogin.vue';
import VueUsers from './views/VueUsers.vue';

Vue.use(Router);

export const router = new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      redirect: '/users'
    },
    {
      path: '/login',
      component: VueLogin
    },
    {
      path: '/users',
      component: VueUsers
    }
  ]
});

router.beforeEach((to, _, next) => {
  const publicPages = ['/login'];
  const authRequired = !publicPages.includes(to.path);
  const loggedIn = localStorage.getItem('token');

  if (authRequired && !loggedIn) {
    next('/login');
  } else {
    next();
  }
});
