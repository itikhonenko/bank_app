import axios from 'axios';
import { BASE_URL, TOKEN_PATH } from '@/constants';

class AuthService {
  login(auth) {
    return axios
      .post(`${BASE_URL}${TOKEN_PATH}`, { auth })
      .then(response => {
        if (response.data.jwt) {
          localStorage.setItem('token', response.data.jwt);
        }

        return response.data.jwt;
      });
  }
}

export default new AuthService();
