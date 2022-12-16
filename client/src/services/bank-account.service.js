

import { API_VERSION, BASE_URL, BANK_ACC_TRANSFER_PATH } from '@/constants';
import axios from 'axios';
import authHeader from './auth-header';

class BankAccountService {
  transferTo(params) {
    return axios.post(`${BASE_URL}${API_VERSION}${BANK_ACC_TRANSFER_PATH}`, params, { headers: authHeader() })
  }
}

export default new BankAccountService();
