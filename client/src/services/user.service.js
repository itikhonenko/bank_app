

import { API_VERSION, BASE_URL, USERS_PATH } from '@/constants';
import axios from 'axios';
import authHeader from './auth-header';

class UserService {
  getUsers() {
    return axios.get(`${BASE_URL}${API_VERSION}${USERS_PATH}`, { headers: authHeader() })
  }
}

export default new UserService();
