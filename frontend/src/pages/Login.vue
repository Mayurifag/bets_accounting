<template lang="pug">
section
  .has-text-centered.columns
    form.column.is-offset-1(@submit.prevent='login')
      h1.title.is-1 Вход
      b-field(label='Email')
        b-input(required v-model='email' type='email' placeholder='Email')
      b-field(label='Пароль')
        b-input(required v-model='password' type='password' placeholder='Пароль'
                password-reveal)

      b-message(type='is-info')
        | Тест: test@test.test : qwerty
      button.button
        | Войти

    form.column(@submit.prevent='register' autocomplete="off")
      h1.title.is-1 Регистрация
      b-field(label='Email')
        b-input(required v-model='register_email' placeholder='Email' type='email'
                autocomplete="new-password")
      b-field(label='Пароль')
        b-input(required v-model='register_password' placeholder='Пароль'
                type='password' password-reveal autocomplete="new-password")
      b-field(label='Подтверждение пароля')
        b-input(required v-model='password_confirmation'
                placeholder='Подтверждение пароля'
                type='password' password-reveal autocomplete="new-password")
      button.button
        | Войти
</template>
// TODO: validation
// TODO: обработка 422 - вывод на экран/тоаст
<script>
export default {
  data() {
    return {
      email: '',
      password: '',
      register_email: '',
      register_password: '',
      password_confirmation: '',
    };
  },
  methods: {
    login() {
      const data = {
        email: this.email,
        password: this.password,
      };
      this.$store.dispatch('login', data)
        .then(() => {
          this.$router.push('/bets');
        });
    },
    register() {
      const data = {
        email: this.register_email,
        password: this.register_password,
        password_confirmation: this.password_confirmation,
      };
      this.$store.dispatch('register', data)
        .then(() => {
          this.$router.push('/bets');
        });
    },
  },
};
</script>

<style scoped lang="scss">
.columns {
  margin-top: 24px;
}
.column {
  max-width: 500px;
  margin: auto;
  margin-top: 0;
}
</style>
