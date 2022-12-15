<template>
  <div class="col-md-12">
    <div class="card card-container">
      <!-- TODO. change avatar for cat -->
      <img
        id="profile-img"
        src="//ssl.gstatic.com/accounts/ui/avatar_2x.png"
        class="profile-img-card"
      />
      <form name="form" @submit.prevent="handleLogin">
        <div class="form-group">
          <label for="email">Email</label>
          <input
            v-model="auth.email"
            v-validate="'required'"
            type="email"
            class="form-control mb-2"
            name="email"
          />
          <div
            v-if="errors.has('email')"
            class="alert alert-danger"
            role="alert"
          >Email is required!</div>
        </div>
        <div class="form-group">
          <label for="password">Password</label>
          <input
            v-model="auth.password"
            v-validate="'required'"
            type="password"
            class="form-control mb-2"
            name="password"
          />
          <div
            v-if="errors.has('password')"
            class="alert alert-danger"
            role="alert"
          >Password is required!</div>
        </div>
        <div class="form-group mt-3 mb-3">
          <button class="btn btn-primary btn-block" :disabled="loading">
            <span v-show="loading" class="spinner-border spinner-border-sm"></span>
            <span>Login</span>
          </button>
        </div>
        <div class="form-group">
          <div v-if="error" class="alert alert-danger" role="alert">Email or password is incorrect!</div>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  name: 'VueLogin',
  data() {
    return {
      loading: false,
      error: false,
      auth: {
        email: '',
        password: ''
      }
    };
  },
  computed: {
    loggedIn() {
      // TODO. getters
      return this.$store.state.auth.status.loggedIn;
    }
  },
  created() {
    if (this.loggedIn) {
      this.$router.push('/users');
    }
  },
  methods: {
    handleLogin() {
      this.loading = true;
      this.$validator.validateAll().then(isValid => {
        if (!isValid) {
          this.loading = false;
          return;
        }
        if (this.auth.email && this.auth.password) {
          this.$store.dispatch('auth/login', this.auth).then(
            () => {
              this.$router.push('/users');
            },
            () => {
              this.loading = false;
              this.error = true
            }
          );
        }
      });
    }
  }
};
</script>

<style scoped>
label {
  display: block;
  margin-top: 10px;
}
.card-container.card {
  /* TODO. remove important */
  max-width: 350px !important;
  padding: 40px 40px;
}
.card {
  background-color: #f7f7f7;
  padding: 20px 25px 30px;
  margin: 0 auto 25px;
  margin-top: 50px;
  -moz-border-radius: 2px;
  -webkit-border-radius: 2px;
  border-radius: 2px;
  -moz-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
  -webkit-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
  box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
}
.profile-img-card {
  width: 96px;
  height: 96px;
  margin: 0 auto 10px;
  display: block;
  -moz-border-radius: 50%;
  -webkit-border-radius: 50%;
  border-radius: 50%;
}
</style>
