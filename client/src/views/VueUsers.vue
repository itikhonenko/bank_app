<template>
  <div class="m-5">
    <div class="card mb-3" style="width: 18rem;" v-for="user in users" :key="user.id">
      <div class="card-body">
        <h5 class="card-title">{{user.email}}</h5>
        <a href="#" class="btn btn-primary">Go somewhere</a>
      </div>
    </div>
  </div>
</template>
<script>
import UserService from '../services/user.service';
export default {
  name: 'VueUsers',
  data() {
    return {
      users: []
    };
  },
  mounted() {
    // TODO. use async
    UserService.getUsers().then(
      response => {
        this.users = response.data;
      }
    );
  }
};
</script>
