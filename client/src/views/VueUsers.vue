<template>
  <div class="m-5">
    <div class="card mb-3" style="width: 28rem;" v-for="user in users" :key="user.id">
      <div class="card-body">
        <div class="card-title">Transfer to -> <b>{{user.email}}</b></div>
          <div class="input-group mb-3">
            <input
              type="number"
              class="form-control"
              v-validate="'required|min_value:1'"
              v-model="accounts[user.id].amount"
              ref="amount"
              placeholder="Amount"
              aria-label="Amount"
              :name="`amount[${user.id}]`"
              aria-describedby="basic-addon2">
              <button class="btn btn-primary" type="submit" @click="transferTo(user.id)">Send</button>
            </div>
            <div
              v-if="errors.has(`amount[${user.id}]`)"
              class="alert alert-danger"
              role="alert"
              >Must be greater than zero!</div>
            <div
              v-if="accounts[user.id].error"
              class="alert alert-danger"
              role="alert"
              >Transfer is not allowed!</div>
      </div>
    </div>
  </div>
</template>
<script>
import UserService from '../services/user.service';
import BankAccountService from '../services/bank-account.service';
export default {
  name: 'VueUsers',
  data() {
    return {
      users: [],
      accounts: {}
    };
  },
  mounted() {
    UserService.getUsers().then(
      response => {
        this.users = response.data;
        response.data.forEach(({ id }) => {
          this.accounts[id] = { amount: '', error: false }
        });
      }
    );
  },
  methods: {
    transferTo(user_id) {
      this.$validator.validate(`amount[${user_id}]`).then(isValid => {
        if (!isValid) {
          return;
        }
        BankAccountService.transferTo({ amount: this.accounts[user_id].amount, user_id })
          .then(
            () => {
              alert('Funds have been transferred')
            },
            () => {
              alert('Transfer is not allowed.')
            }
          )
          .finally(() => {
            this.$refs.amount.forEach(input => {
              input.value = ''
            });
            for (let [_, acc] of Object.entries(this.accounts)) {
              acc.amount = ''
            }
          });
      });
    }
  }
};
</script>
