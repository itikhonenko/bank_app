

import axios from 'axios';
import authHeader from './auth-header';

// TODO.
const API_URL = 'http://localhost:3000/api/v1';

class UserService {
  getUsers() {
    return axios.get(`${API_URL}/users`, { headers: authHeader() });
  }
}

export default new UserService();
