import AuthService from '../services/auth.service';

const token = localStorage.getItem('token');
const initialState = { status: { loggedIn: !!token } }

export const auth = {
  namespaced: true,
  state: initialState,
  actions: {
    login({ commit }, auth) {
      // TODO. await async
      return AuthService.login(auth).then(
        token => {
          commit('loginSuccess', token);
          return Promise.resolve(token);
        },
        error => {
          commit('loginFailure');
          return Promise.reject(error);
        }
      );
    },
  },
  mutations: {
    loginSuccess(state) {
      state.status.loggedIn = true;
    },
    loginFailure(state) {
      state.status.loggedIn = false;
    }
  }
};
