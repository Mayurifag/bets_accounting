<template lang="pug">
section.container.login_form
  form.login(@submit.prevent='login')
    b-field(horizontal label='Email')
      //- TODO: убрать
      b-input(required v-model='email' type='email' placeholder='Email', value='test@test.com')
    b-field(horizontal label='Пароль')
      b-input(required v-model='password' type='password' placeholder='Пароль', value='test')
    button.button
      | Login
</template>

<script>
export default {
  data(){
    return {
      // TODO: убрать
      email : "test@test.com",
      password : "test"
    }
  },
  methods: {
    login: function () {
      let data = {
        email: this.email,
        password: this.password
      }
      this.$store.dispatch('login', data)
      .then(() => {
        this.$router.push('/bets');
      })
      .catch(err => console.log(err))
    }
  }

}
</script>

<style scoped lang="scss">
.login_form {
  width: 400px;
  margin-top: 24px;
}
</style>
