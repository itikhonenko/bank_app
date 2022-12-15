import axios from 'axios';

// TODO. move it to constants
const API_URL = 'http://localhost:3000/user_token';

class AuthService {
  login(auth) {
    return axios
      .post(API_URL, { auth })
      .then(response => {
        if (response.data.jwt) {
          localStorage.setItem('token', response.data.jwt);
        }

        return response.data.jwt;
      });
  }
}

export default new AuthService();
